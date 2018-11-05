class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners=Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet=Pet.create(name: params["pet_name"])
    if params["owner_name"]==""
      @pet.owner_id=params["owner"]
      @pet.save

    else
      @pet.owner=Owner.new(name: params["owner_name"])
      @pet.save

    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pets=Pet.all
    @owners=Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end
  get '/pets/:id' do
    @pets=Pet.all
    @owners=Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.name=params['pet']['name']
    @pet.save
    if params['owner']['name'].empty?
      @pet.owner=Owner.find(params["pet"]['owner_id'])
      @pet.save
    else
      @pet.owner=Owner.new(name: params['owner']['name'])
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end
end
