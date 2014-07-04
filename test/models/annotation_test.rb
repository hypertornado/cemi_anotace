require 'test_helper'

class AnnotationTest < ActiveSupport::TestCase
  test "import dont overwrite existing" do
    Annotation.delete_all

    Annotation.import_line("1 a 0 - txt img")
    Annotation.import_line("1 b 0 - txt img")

    assert_equal 1, Annotation.all.size
    assert_equal "a", Annotation.first.label
  end

  test "select job from empty database" do
    prepare_before_test

    assert_equal nil, Annotation.get_annotation(1)
  end

  test "give already taken annotation" do
    prepare_before_test

    Annotation.import_line("1 a 0 ondra txt img")
    Annotation.import_line("2 a 0 ondra txt img")
    Annotation.import_line("3 a 0 ondra txt img")

    a = Annotation.find(2)
    a.user_id = 1
    a.save

    assert_equal 2, Annotation.get_annotation(1).id

    a = Annotation.find(2)
    a.finished = Time.now
    a.save

    assert_equal 1, Annotation.get_annotation(1).id


  end

  test "give me some anotation" do
    prepare_before_test

    Annotation.import_line("1 a 0 - txt img")
    assert_equal 1, Annotation.get_annotation(1).id
  end

  test "dont give me anotations for other people" do
    prepare_before_test

    Annotation.import_line("1 a 0 karel txt img")

    assert_equal nil, Annotation.get_annotation(1)

  end

  test "sort by priority" do
    prepare_before_test

    Annotation.import_line("1 a 0 - txt img")
    Annotation.import_line("2 a 2 - txt img")
    Annotation.import_line("3 a 1 - txt img")

    assert_equal 2, Annotation.get_annotation(1).id
    assert_equal 1, Annotation.find(2).user_id
    assert_equal nil, Annotation.find(2).finished

  end

  test "save annotation" do
    prepare_before_test

    Annotation.import_line("3 a 0 - txt img")

    annotation = Annotation.get_annotation(1)

    Annotation.save_annotation(annotation.id, 1, "ok", "fail")

    annotation = Annotation.find(annotation.id)

    assert_equal "ok", annotation.appropriate
    assert_equal "fail", annotation.not_appropriate
    assert_not_equal nil, annotation.finished

  end

  test "dont give skipped annotations" do
    prepare_before_test

    Annotation.import_line("3 a 0 - txt img")

    annotation = Annotation.get_annotation(1)

    Annotation.skip_annotation(annotation.id, 1)

    assert_equal nil, Annotation.get_annotation(1)
  end

  test "export format" do
    prepare_before_test

    Annotation.import_line("1 a 0 - txt img")
    Annotation.import_line("2 a 2 - txt img")
    Annotation.import_line("3 a 1 - txt img")

    a = Annotation.get_annotation(1)
    Annotation.save_annotation(a.id, 1, "ok", "fail")

    a = Annotation.get_annotation(1)
    Annotation.skip_annotation(a.id, 1)

    exported = Annotation.export_annotations()

    assert_equal 2, exported.size

  end

  def prepare_before_test
    Annotation.delete_all
    User.delete_all
    User.new(name: "ondra", password: "p", id: 1).save
  end

end
