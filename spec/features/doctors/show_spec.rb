require 'rails_helper'

RSpec.describe 'doctors show page' do
  before :each do
    @hospital = Hospital.create(name: "Grey Sloan Memorial Hospital")
    @dr_bailey = @hospital.doctors.create(name: "Miranda Bailey", specialty: "General Surgery", university: "Stanford University")
  end

  it 'shows doctor information' do
    visit "/doctors/#{@dr_bailey.id}"

    expect(page).to have_content(@dr_bailey.name)
    expect(page).to have_content(@dr_bailey.specialty)
    expect(page).to have_content(@dr_bailey.university)
  end

  it 'show the hospital where the doctor works' do
    visit "/doctors/#{@dr_bailey.id}"

    expect(page).to have_content(@hospital.name)
  end

  it 'shows the names of the doctors patients' do
    
  end
end