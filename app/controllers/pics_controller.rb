class PicsController < ApplicationController
	before_action :find_pic, only: [:show, :edit, :update, :destroy, :upvote]
	before_action :authenticate_user!, except: [:index, :show]

	def show
	end


	def index
		@pics = Pic.all.order("created_at DESC")
	end

	def new
		@pic = current_user.pics.build
	end

	def create
		@pic = current_user.pics.build(pic_params)
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


	def upvote
		@pic.upvote_by current_user
		redirect_to :back
	end	
	private

	def find_pic 
		@pic = Pic.find(params[:id])
	end

	def pic_params
		params.require(:pic).permit(:title, :description, :image)
	end		
end
