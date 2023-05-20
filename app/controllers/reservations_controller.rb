class ReservationsController < ApplicationController
  before_action :permit_params

  def new_reservation
    required_show = Show.find_by(id: @permitted_params[:show_id])
    return render_error('The show does not exist') if required_show.nil?

    reservation_user = User.find_by(id: @permitted_params[:user_id])
    return render_error('The user does not exist') if reservation_user.nil?

    required_section = Section.find_by(id: @permitted_params[:section_id])
    return render_error('Section does not exist') if required_section.nil?
    return render_error('Section with numerated places') if !required_section.without_numeration && @permitted_params[:section_location_ids].nil?

    if @permitted_params[:section_location_ids].nil? && (@permitted_params[:section_id].nil? || @permitted_params[:quantity].nil?)
      return render_error('You must choice locations or section and quantity')
    end

    required_section_locations = select_required_section_locations
    return render_error('Locations do not exist') if !required_section_locations.any?

    unavailabled_required_section_locations = required_section_locations.not_availables
    return render_error('There are required locations that now are not availables') if unavailabled_required_section_locations.any?

    reservation = create_reservation(required_show, reservation_user, required_section_locations)
    return render_error('Unexpected error creating the reservation, please, try again') unless reservation

    render json: { ticket: ::DataFormatters::TicketDataFormatter.new(reservation).generate_ticket }
  end

  private
    def permit_params
      @permitted_params = params.permit(:user_id, :section_location_ids, :show_id, :section_id, :quantity)
    end

    def render_error(message)
      render json: { error: message }
    end

    def create_reservation(required_show, reservation_user, required_section_locations)
      total = required_section_locations.sum { |section_location| section_location.section.price }
      currency = required_section_locations.first.section.currency
      Reservation.create(
        user_id: reservation_user.id,
        section_locations: required_section_locations,
        show_id: required_show.id,
        total: total,
        currency: currency
      )
    end

    def select_required_section_locations
      if !@permitted_params[:section_location_ids].nil?
        SectionLocation.where(
          'section_locations.id IN (?)', @permitted_params[:section_location_ids].split(',')
        ).includes(:location, :section)
      elsif !@permitted_params[:section_id].nil? && !@permitted_params[:quantity].nil?
        SectionLocation.availables.joins(:section).where(
          'section_locations.section_id = ?
          AND sections.without_numeration IS TRUE', @permitted_params[:section_id]
        ).order('RANDOM()').includes(:location, :section).limit(@permitted_params[:quantity])
      end
    end
end
