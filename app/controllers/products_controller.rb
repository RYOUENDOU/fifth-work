class ProductsController < ApplicationController
	
  add_breadcrumb 'トップ', :products_path	 
  add_breadcrumb '商品詳細', :product_path
  add_breadcrumb '出品', :new_product_path
  


  PER = 50
  def index
  	@products = Product.page(params[:page]).per(PER)
    @cart_item = CartItem.new
  end

  def new
  	@product = Product.new
    @category = Category.new
    3.times {@product.product_images.build}
  end

  def create
   	@product = Product.new(product_params)
    @product.product_images.build
    @product.user_id = current_user.id
	  @product.save
    redirect_to products_path	
  end

  def show
  	@product = Product.find(params[:id])
    @products = Product.includes(:product_images) 
  end

  def edit
 	  @product = Product.find(params[:id])
  end

  def update
  	@product = Product.find(params[:id]) 
    @product.update(product_params)
    @product_images = @product.product_images
  	redirect_to products_path	
  end

  def destroy
  	@product = Product.find(params[:id])
  	@product.destroy
  	redirect_to products_path 		  	
  end

  def category
    @categories = Category.all  
  end

  private
  	def product_params
  		params.require(:product).permit(:title, :price, :description, :is_available,:image, :category_id, product_images_attributes: [:image_id])
  	end
end
