class MainController < ApplicationController
  def index
    return redirect_to "/login" if session[:user_id] == nil
    current_user = User.find_by_id(session[:user_id])
    raise "no user" if current_user == nil

    @annotation = Annotation.get_annotation(current_user.id)
    @username = current_user.name

    if @annotation == nil
      render "no_annotation"
      return
    end

    text_path = "#{File.dirname(__FILE__)}/../../public/#{@annotation.text_file}"

    @text = ""

    File.open(text_path) do |f|
      gz = Zlib::GzipReader.new(f)
      @text = gz.read
      gz.close
    end

    @annotation_count = Annotation.where(user_id: current_user.id).count

    @images = @annotation.image_files.split(";")

    render :layout => false
  end

  def save
    current_user = User.find_by_id(session[:user_id])
    raise "no user" if current_user == nil

    Annotation.save_annotation(params[:id], current_user.id, params[:appropriate], params[:not_appropriate] )

    render :text => "OK"
  end

  def skip
    current_user = User.find_by_id(session[:user_id])
    raise "no user" if current_user == nil

    Annotation.skip_annotation(params[:id], current_user.id)

    render :text => "OK"
  end

  def instrukce
    instructions = File.read(Rails.root.join('public/instrukce.md'))
    @content = BlueCloth.new(instructions).to_html
  end

  def login
    reset_session
    instructions = File.read(Rails.root.join('public/annotation_short_info.md'))
    @instructions = BlueCloth.new(instructions).to_html
  end

  def do_login
    user = User.find_by_name(params["username"])
    if user != nil and user.password == params["password"]
      session[:user_id] = user.id
      redirect_to "/"
    else
      redirect_to "/login?fail=true"
    end
  end

  def logout
    reset_session
    redirect_to "/"
  end
end
