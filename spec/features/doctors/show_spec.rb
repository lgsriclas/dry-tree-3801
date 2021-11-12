require 'rails_helper'

RSpec.describe 'doctor show page' do
  before :each do
    @hospital = Hospital.create!(name: "Grey Sloan Memorial Hospital")

    @dr_bailey = @hospital.doctors.create!(name: "Miranda Bailey", specialty: "General Surgery", university: "Stanford University")
    @dr_shepherd = @hospital.doctors.create!(name: "Derek Shepherd", specialty: "Neurosurgery", university: "Bowdoin College")
    @dr_sanders = @hospital.doctors.create!(name: "Larry Sanders", specialty: "Emergency Medicine", university: "Stanford University")

    @patient_1 = Patient.create!(name: "Sally Brown", age: 8)
    @patient_2 = Patient.create!(name: "Charlie Brown", age: 10)
    @patient_3 = Patient.create!(name: "Linus van Pelt", age: 9)
    @patient_4 = Patient.create!(name: "Lucy van Pelt", age: 11)

    @dp_1 = DoctorPatient.create!(doctor: @dr_bailey, patient: @patient_1)
    @dp_2 = DoctorPatient.create!(doctor: @dr_bailey, patient: @patient_2)
    @dp_3 = DoctorPatient.create(doctor: @dr_shepherd, patient: @patient_3)
    @dp_4 = DoctorPatient.create(doctor: @dr_shepherd, patient: @patient_4)
  end

  it 'shows doctor information' do
    visit "/doctors/#{@dr_bailey.id}"

    expect(page).to have_content(@dr_bailey.name)
    expect(page).to have_content(@dr_bailey.specialty)
    expect(page).to have_content(@dr_bailey.university)
    expect(page).to_not have_content(@dr_shepherd.name)
  end

  it 'show the hospital where the doctor works' do
    visit "/doctors/#{@dr_bailey.id}"

    expect(page).to have_content(@hospital.name)
  end

  it 'shows the names of the doctors patients' do
    visit "/doctors/#{@dr_shepherd.id}"

    expect(page).to have_content(@dr_shepherd.name)
    expect(page).to have_content(@patient_3.name)
    expect(page).to have_content(@patient_4.name)
    expect(page).to_not have_content(@patient_1.name)
    expect(page).to_not have_content(@patient_2.name)
  end

  it 'has a button to remove patients from doctor caseload' do
    visit "/doctors/#{@dr_shepherd.id}"

    expect(page).to have_button "Remove #{@patient_3.name}"
    expect(page).to have_button "Remove #{@patient_4.name}"
  end

  it 'redirects to doctor show page after removing a patient from a doctor' do
    visit "/doctors/#{@dr_bailey.id}"

    within("#dp-#{@dp_1.id}") do
      click_button "Remove #{@patient_1.name}"
    end

    expect(current_path).to eq("/doctors/#{@dr_bailey.id}")
    expect(page).to_not have_content(@patient_1.name)

    within("#dp-#{@dp_2.id}") do
      click_button "Remove #{@patient_2.name}"
    end

    expect(current_path).to eq("/doctors/#{@dr_bailey.id}")
    expect(page).to_not have_content(@patient_2.name)
  end
end