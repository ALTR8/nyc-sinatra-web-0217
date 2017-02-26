

class FiguresController < ApplicationController

	get '/figures' do 
		@figures = Figure.all
		erb :"/figures/index"	
	end

	get '/figures/new' do
		erb :"/figures/new" #form to view
	end

	get '/figures/:id' do
		@figure = Figure.find(params[:id])
		erb :"/figures/show"
	end

	get '/figures/:id/edit' do 
		@figure = Figure.find(params[:id])
		erb :"/figures/edit"
	end

	post '/figures' do
		@figure = Figure.create(params["figure"])


		if !params["title"]["name"].empty? #if we can't find the title name, create it. Can be done w/ .find_or_create?
			@figure.titles << Title.create(params[:title])
		end

		if !params["landmark"]["name"].empty?
			@figure.landmarks << Landmark.create(params[:landmark])
		end

		@figure.save
		redirect to "/figures/#{@figure.id}"
	end

	post '/figures/:id/delete' do
		@figure = Figure.find(params[:id])
		@figure.destroy
		redirect to '/figures'
	end



	post '/figures/:id' do 
		@figure = Figure.find(params[:id])
		@figure.update(params["figure"])
		if !params["title"]["name"].empty? #if we can't find the title name, create it. Can be done w/ .find_or_create?
			@figure.titles << Title.create(params[:title])
		end

		if !params["landmark"]["name"].empty?
			@figure.landmarks << Landmark.create(params[:landmark])
		end

		@figure.save
		redirect to "/figures/#{@figure.id}"

	end
end
