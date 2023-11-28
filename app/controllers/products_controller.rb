class ProductsController < ApplicationController 
    before_action :authenticate 

   
    def create 
        #  for now we are not cosidering the color and brand later we will cover that so that product count with different color and barnd can be considered and based on that also we can show its avalibility 
        new_product = {}
        new_supplier_product = {}
        
        if permitted_params[:product_request] == 'new_product'
          [:name, :description, :category, :sub_category, :length, :breadth, :height, :weight, :status].each do |itr|
            new_product[itr] = permitted_params[itr]
          end
      
          @product = Product.new(new_product)
      
          unless @product.valid?
            return render json: {error: {message: @product.errors.full_messages}}, status: :unprocessable_entity
          end
      
          @product.save
        else
          @product = Product.find(permitted_params[:product_id])
        end
      
        [:price, :quantity, :color, :brand].each do |itr|
          new_supplier_product[itr] = permitted_params[itr.to_sym]
        end
      
        new_supplier_product[:product_id] = @product.id 
        new_supplier_product[:supplier_account_id] = @current_user.supplier_account.id
      
        @new_supplier_product = SupplierProduct.new(new_supplier_product)
      
        if @new_supplier_product.save
          return render json: {data:{message: 'Request submitted successfully', supplier_product_id: @new_supplier_product.id} } 
        else
          if permitted_params[:product_request] == 'new_product'
            @product.destroy
          end
      
          return render json: {error: {message: @new_supplier_product.errors.full_messages}}, status: :unprocessable_entity 
        end
    end
      

    def index
        @supplier_products = SupplierProduct.includes(:supplier_account, :product)
                                       .select('supplier_products.*, supplier_accounts.*, products.*, products.name AS product_name, products.description AS product_description')
                                       .references(:supplier_account, :product)
                                       
       render json: { data: @supplier_products}
    end

    def update
        # only admin can modify the data from products, sow supplier will modify the data from supplier products
        new_supplier_product = {}
        [:price, :quantity, :color, :brand].each{ |itr| new_supplier_product[itr] = permitted_params[itr.to_sym]}
        @supplier_account = @current_user.supplier_account
        @supplier_product = @supplier_account.supplier_products.where(id: :supplier_product_id).first

        if @supplier_product.update(new_supplier_product)
            render json: {data: {message: "Product Updated successfully", data: @supplier_product}}
        else
            render json: { error: {message: @supplier_product.errors.full_messages}}
        end
    end

    def destroy
        @supplier_account = @current_user.supplier_account
        @supplier_product = @supplier_account.supplier_products.where(id: :supplier_product_id).first
        @supplier_product.destroy
    end

    private
    def permitted_params
        params.require(:data).permit(:name, :description, :category, :sub_category, :length, :breadth, :height, :weight, :price, :color, :brand, :quantity, :product_image, :product_request, :product_id, :supplier_product_id, :supplier_account_id)
    end
end 