describe "Medic" do

  before do
    @store = Medic::Store.shared
  end

  describe ".available?" do
    it "determines if HealthKit is available" do
      Medic.available?.should == true
    end

    it "has an .is_available? alias" do
      Medic.is_available?.should == true
    end
  end

  describe ".authorize" do
    it "delegates to Medic::Store" do
      @store.stub! 'authorize' do |types, block|
        types.should.be.kind_of? Hash
        block.should.respond_to? :call
      end
      Medic.authorize(read: :step_count){|success, error|}
    end
  end

  describe ".authorized?" do
    it "delegates to Medic::Store" do
      @store.stub! 'authorized?' do |sym|
        sym.should.be.kind_of? Symbol
      end
      Medic.authorized? :step_count
    end

    it "has an .is_authorized? alias" do
      Medic.method(:is_authorized?).should == Medic.method(:authorized?)
    end

    it "has an .authorized_for? alias" do
      Medic.method(:authorized_for?).should == Medic.method(:authorized?)
    end

    it "has an .is_authorized_for? alias" do
      Medic.method(:is_authorized_for?).should == Medic.method(:authorized?)
    end
  end

end
