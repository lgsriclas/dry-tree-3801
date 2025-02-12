require 'rails_helper'

RSpec.describe 'patient index page' do
  before :each do
    @hospital = Hospital.create!(name: "Grey Sloan Memorial Hospital")

    @dr_bailey = @hospital.doctors.create!(name: "Miranda Bailey", specialty: "General Surgery", university: "Stanford University")
    @dr_shepherd = @hospital.doctors.create!(name: "Derek Shepherd ", specialty: "Neurosurgery", university: "Bowdoin College")

    @patient_1 = Patient.create!(name: "Sally Brown", age: 8)
    @patient_2 = Patient.create!(name: "Charlie Brown", age: 10)
    @patient_3 = Patient.create!(name: "Linus van Pelt", age: 9)
    @patient_4 = Patient.create!(name: "Lucy van Pelt", age: 11)

    @dp_1 = DoctorPatient.create!(doctor: @dr_bailey, patient: @patient_1)
    @dp_2 = DoctorPatient.create!(doctor: @dr_bailey, patient: @patient_2)
    @dp_3 = DoctorPatient.create(doctor: @dr_shepherd, patient: @patient_3)
    @dp_4 = DoctorPatient.create(doctor: @dr_shepherd, patient: @patient_4)
  end

  it 'lists all the patients from oldest to youngest' do
    visit "/patients"

    expect(page).to have_content(@patient_1.name)
    expect(page).to have_content(@patient_2.name)
    expect(page).to have_content(@patient_3.name)
    expect(page).to have_content(@patient_4.name)
  end
end