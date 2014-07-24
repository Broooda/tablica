require 'rails_helper'

RSpec.describe User, :type => :model do

    it 'should have :id, :email, :encrypted_password attributes'do
    expect(subject.attributes).to include('id', 'email', 'encrypted_password')
end

    it 'should have :name, :surname, :admin, :accepted attributes' do
    expect(subject.attributes).to include('name', 'surname', 'admin', 'accepted')
end

    it 'should require name, surname, email, admin, accepted' do
    expect(User.new).not_to be_valid
    expect(User.new(name: "Jan", surname: "Kowalski", password: "haslohaslo", email: "mail@mail.com", admin: false, accepted: true)).to be_valid
end

it "should have one default_work_time" do
    t = User.reflect_on_association(:default_work_time)
    expect(t.macro).to equal :has_one
end

it "should have many hours_plan" do
    t = User.reflect_on_association(:hours_plan)
    expect(t.macro).to equal :has_many
end

it "should have many holiday" do
    t = User.reflect_on_association(:holiday)
    expect(t.macro).to equal :has_many
end


end

