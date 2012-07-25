describe "Back Row" do
  tests_row :back

  it "should initialize with correct settings" do
    @row.object.class.should == Formotion::RowType::BackRow
  end

  it "should pop subform on select" do
    fake_delegate = FakeDelegateClass.new
    @row.object.on_select(nil, fake_delegate)
    fake_delegate.pop_subform_called.should == true
  end
end

class FakeDelegateClass
  attr_accessor :pop_subform_called
  def pop_subform
    self.pop_subform_called = true
  end
end