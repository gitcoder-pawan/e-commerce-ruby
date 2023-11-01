class AddressesController <ApllicationController
    # JwtService > authenticate included in application controller
    before_action :authenticate

    def create 
        new_permitted_params = new_permitted_params.merge({account_id: @current_user.id})
        @address = Addresses.new(new_permitted_params)
        if @address.save
            render json: {message: "Address saved successfully!"}, status: :created
        else
            render json: { errors: @address.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def index
        @addresses = @current_user.addresses
        render json: {data: @addresses}
    end

    def update
        @address = Address.find(address_id.to_i)
        if @address.empty?
            return render json: {errors: "Invalid address Id" }
        end

        if @address.update(permitted_params)
            render json: {message: "Address updated sucessfully!"}
        else
            render json: {errors: @address.errors.full_messages}
        end
    end 

    def destroy
        @address = Address.find(address_id.to_i)
        address.destroy
        render json: {message: "Deleted successfully!"}
    end

    private

    def permitted_params
        params.require(:data).permit(:area, :post_office, :police_station, :city, :state, :country, :pin_code, :landmark, :address_id)
    end
end
