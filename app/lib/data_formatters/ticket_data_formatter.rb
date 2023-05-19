module DataFormatters
  class TicketDataFormatter
    def initialize(reservation)
      @reservation = reservation
      @show = @reservation.show
      @place = @show.place
    end

    def generate_ticket
      locations_data = get_locations_data(@reservation.section_locations.includes(:location, :section))
      {
        ticket_number: 'N-%08d' % @reservation.id,
        total: @reservation.total,
        user: {
          name: @reservation.user.name,
          document_number: @reservation.user.document_number,
          phone_number: @reservation.user.phone_number
        },
        show: {
          name: @show.name,
          day_and_hour: @show.day_and_hour.strftime('%d/%m/%Y %H:%Mhs')
        },
        place: {
          name: @place.name,
          country: @place.country,
          state: @place.state,
          city: @place.city,
          address: @place.address
        },
        locations: locations_data
      }
    end

    private
      def get_locations_data(section_locations)
        locations_data = []
        section_locations.each do | section_location |
          locations_data.push(
            {
              location_row: section_location.section.without_numeration ? nil : section_location.location.location_row,
              location_number: section_location.section.without_numeration ? nil : section_location.location.location_number,
              section: section_location.section.name,
              price: section_location.section.price
            }
          )
        end
        locations_data
      end
  end
end
