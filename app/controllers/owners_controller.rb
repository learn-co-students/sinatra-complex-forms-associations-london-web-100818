class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index' 
  end

  get '/owners/new' do
    @pets = Pet.all
    erb :'/owners/new'
  end
  
  post '/owners' do
    @owner = Owner.create(params[:owner])
    if !params[:pet][:name].empty?
      pet = Pet.find_or_create_by(name: params[:pet][:name])
      @owner.pets << pet
    end
    redirect "owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do 
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :"owners/edit"
  end

  patch '/owners/:id/edit' do 
    owner = Owner.find(params[:id])
    owner.update(params[:owner])
    if !params[:pet][:name].empty?
      pet = Pet.find_or_create_by(name: params[:pet][:name])
      owner.pets << pet
    end
    redirect "owners/#{owner.id}"
  end

  get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

end