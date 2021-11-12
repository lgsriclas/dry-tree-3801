class DoctorPatientsController < ApplicationController

  def destroy
    @doctor = Doctor.find(params[:doctor_id])
    @doctor.patients.delete(params[:patient_id])
    redirect_to "/doctors/#{@doctor.id}"
  end
end