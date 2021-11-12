require 'rails_helper'

RSpec.describe Patient do
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

  describe 'relationships' do
    it { should have_many(:doctor_patients) }
    it { should have_many(:doctors).through(:doctor_patients)}
  end

  describe 'class methods' do
    it 'returns patients in age order' do
      results = Patient.age_order.map do |patient|
        patient.age
      end

      expect(results).to eq([@patient_4.age, @patient_2.age, @patient_3.age, @patient_1.age])
    end
  end
end