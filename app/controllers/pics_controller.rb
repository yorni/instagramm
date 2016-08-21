class PicsController < ApplicationController
	before_action :find_pic, only: [:show, :edit, :update, :destroy]
	
	def show
	end


	def index
		@pics = Pic.all.order("created_at DESC")
	end

	def new
		@pic = Pic.new
	end

	def create
		@pic = Pic.new(pic_params)
		if @pic.save
			redirect_to @pic, notice: "Successfully created!"
		else
			render 'new'
		end	
	end

	def destroy
		@pic.destroy
		redirect_to root_path
	end
	
	def edit 
	end	

	def update 
		if @pic.update(pic_params)
			redirect_to @pic, notice: "Update success!"
		else
			render 'edit'
		end		
	end

	private

	def find_pic 
		@pic = Pic.find(params[:id])
	end

	def pic_params
		params.require(:pic).permit(:title, :description)
	end		
end
