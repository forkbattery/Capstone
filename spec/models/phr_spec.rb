require 'spec_helper'

describe Phr do
  
  	let(:user) { FactoryGirl.create(:user) }

  	before { @phr = user.phrs.build(	first_name: "ExampleFirstName",
  							last_name: "ExampleLastName",
  							date_of_birth: DateTime.civil(1980, 1, 2),
  							gender: "Male",
  							blood_type: "A+",
  							health_card_no: "1234567890AB")}

  subject { @phr }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:date_of_birth) }
  it { should respond_to(:gender) }
  it { should respond_to(:blood_type) }
  it { should respond_to(:health_card_no) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when first name is not present" do
    before { @phr.first_name = " " }
    it { should_not be_valid }
  end

  describe "when last name is not present" do
    before { @phr.last_name = " " }
    it { should_not be_valid }
  end

  describe "when date of birth is not present" do
    before { @phr.date_of_birth = " " }
    it { should_not be_valid }
  end

  describe "when gender is not present" do
    before { @phr.gender = " " }
    it { should_not be_valid }
  end

  describe "when blood type is not present" do
    before { @phr.blood_type = " " }
    it { should_not be_valid }
  end

  describe "when health card number is not present" do
    before { @phr.health_card_no = " " }
    it { should_not be_valid }
  end

  describe "when user id is not present" do
    before { @phr.user_id = nil }
    it { should_not be_valid }
  end

  describe "when first name is too long" do
    before { @phr.first_name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when last name is too long" do
    before { @phr.last_name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when gender is too long" do
    before { @phr.gender = "a" * 11 }
    it { should_not be_valid }
  end

  describe "when blood type is too long" do
    before { @phr.blood_type = "a" * 4 }
    it { should_not be_valid }
  end

  describe "when blood type is too short" do
    before { @phr.blood_type = "a" }
    it { should_not be_valid }
  end

  describe "when blood type is invalid" do
  	it "should be invalid" do
  		bloods = %w[a + abc abcd ba+ ++ +++ c+ ]
  		bloods.each do |invalid_blood|
  			@phr.blood_type = invalid_blood
  			expect(@phr).not_to be_valid
  		end
  	end
  end

  describe "when blood type is valid" do
  	it "should be valid" do
  		bloods = %w[a+ a+ b+ b- ab+ ab- o+ o-]
  		bloods.each do |valid_blood|
  			@phr.blood_type = valid_blood
  			expect(@phr).to be_valid
  		end
  	end
  end

  describe "blood type with bad case" do
    it "should be saved as all lower-case" do
    	bloods = %w[aB+ A+]
    	bloods.each do |bad_case_blood|
    
	      @phr.blood_type = bad_case_blood
	      @phr.save
	      expect(@phr.reload.blood_type).to eq bad_case_blood.downcase
	  end
    end
  end

  describe "when health card number is too long" do
    before { @phr.health_card_no = "a" * 51 }
    it { should_not be_valid }
  end
end