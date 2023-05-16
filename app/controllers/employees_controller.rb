class EmployeesController < ApplicationController
  before_action :get_employee, only: [:edit, :update, :destroy]

  def index
    @employees = Employee.includes(:addresses).all
  end

  def new
    @employee = Employee.new
    @employee.addresses.build
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to employees_path, notice: "you have successfully created an employee"
    else
      flash.now[:alert] = "Employee's not created!"
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @employee.update(employee_params)
      redirect_to employees_path, notice: "you have successfully updated the employee"
    else
      flash.now[:alert] = "Employee's not updated!"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @employee.destroy
      flash[:notice] = "you have successfully deleted the employee"
    else
      flash[:alert] = "employee's not deleted"
    end
    redirect_to employees_path
  end

  def search
    @employees = params[:commit] == "Search" ? Employee.where('employee_name LIKE ?', "%#{params[:employee_name].strip}%") : Employee.all
    render :index
  end

  private

    def get_employee
      @employee = Employee.find(params[:id])
    end

    def employee_params
      params.require(:employee).permit(:employee_name, :email, :password, :birth_date, :gender, :mobile_number, :document, addresses_attributes: [:id, :house_name, :street_name, :road], hobbies: [])
    end
end
