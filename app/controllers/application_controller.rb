class ApplicationController < Sinatra::Base

  set :default_content_type, 'application/json'

  # add routes
  get '/bakeries' do
    # get all the bakeries from the database
    bakeries = Bakery.all
    # send them back as a JSON array
    bakeries.to_json
  end

  get '/bakeries/:id' do
    bakery = Bakery.find(params[:id])
    bakery.to_json(include: :baked_goods)
  end

  get '/baked_goods/by_price' do
    all_goods = Bakery.all.map do |bakery|
      bakery.baked_goods
    end
    sorted_goods = all_goods.order("price DESC")
    sorted_goods.to_json
  end

  get '/baked_goods/most_expensive' do
    all_goods = Bakery.all.map do |bakery|
      bakery.baked_goods
    end
    all_goods.maximum(:price).to_json
  end

end