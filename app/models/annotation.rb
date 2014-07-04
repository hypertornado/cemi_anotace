class Annotation < ActiveRecord::Base

  def self.import_line line
    #puts line
    line.chomp!
    parts = line.split(/ +/)

    annotation = Annotation.find_by_id(parts[0].to_i)
    return if annotation != nil

    annotation = Annotation.new()

    annotation.id = parts[0].to_i
    annotation.label = parts[1]
    annotation.priority = parts[2].to_i
    annotation.prefer_user = parts[3]
    annotation.text_file = parts[4]
    annotation.image_files = parts[5]

    annotation.save
  end

  def self.get_annotation(userid)

    Annotation.transaction do

      username = User.find(userid).name

      #if already taken
      results = Annotation.where("user_id = ? and finished is null and skipped is null", userid)
      return results.first if results != nil and results.size > 0

      ret = nil

      #i am prefered user
      results = Annotation.where("prefer_user = ? and user_id is null", username).order("priority DESC")
      ret = results.first if results != nil and results.size > 0

      #no prefered user
      if ret == nil
        results = Annotation.where("prefer_user = ? and user_id is null", "-").order("priority DESC")
        ret = results.first if results != nil and results.size > 0
      end

      if ret != nil
        ret.user_id = userid
        ret.save
      end

      #no annotation for me
      return ret

    end
  end

  def self.save_annotation(id, userid, appropriate, not_appropriate)
    user = User.find(userid)
    annotation = Annotation.find(id)

    raise "not right user" unless annotation.user_id == userid

    annotation.appropriate = appropriate
    annotation.not_appropriate = not_appropriate
    annotation.finished = Time.now

    annotation.save
  end

  def self.skip_annotation(id, userid)
    user = User.find(userid)
    annotation = Annotation.find(id)

    raise "not right user" unless annotation.user_id == userid

    annotation.finished = Time.now
    annotation.skipped = true

    annotation.save

  end

  def self.export_annotations
    ret = []

    Annotation.order("id ASC").each do |a|
      next if a.finished == nil and a.skipped == nil
      user = User.find(a.user_id)
      skipped = "False"
      skipped = "True" if a.skipped == true
      line = "#{a.id}\t#{user.name}\t#{a.finished.to_i}\t#{skipped}\t#{a.appropriate}\t#{a.not_appropriate}"
      ret.push(line)
    end

    return ret

  end

end
