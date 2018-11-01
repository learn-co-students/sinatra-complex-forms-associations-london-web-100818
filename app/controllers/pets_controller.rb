class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @pets = Pet.all
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    if !params.keys.include?("pet")
      owner_id = Owner.create(name: params["owner_name"]).id
    else
      owner_id = params[:pet][:owner_id]
    end
    
    @pet = Pet.create(name: params[:name], owner_id: owner_id)
    
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owner = Owner.find(@pet.owner_id)
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @owner = Owner.find(@pet.owner_id)
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])

    if !params[:owner][:name].empty?
      owner_id = Owner.create(name: params[:owner][:name]).id
    else
      owner_id = params[:pet][:owner_id]
    end

    @pet = Pet.update(params[:id], name: params[:pet_name], owner_id: owner_id)

    redirect to "pets/#{@pet.id}"
  end
end