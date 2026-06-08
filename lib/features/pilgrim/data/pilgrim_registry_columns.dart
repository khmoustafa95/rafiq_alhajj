/// Supabase `pilgrim_details` columns for registry queries.
abstract final class PilgrimRegistryColumns {
  static const detailsSelect = '''
registry_id, kobo_id, sequence, cluster, coordinator_name, sticker_number,
visa_number, barcode_number, full_name_ar, mother_name_ar, birth_date,
first_name_en, last_name_en, father_name_en, mother_name_en,
passport_number, passport_expiry_date, passport_issue_date, travel_permit_number,
gender, body_size, group_name, companion_name, relation,
request_type, housing_type, hady_status, residence,
health_status, needs_wheelchair, is_smoking, health_card, is_vaccinated,
makkah_hotel, makkah_floor, makkah_room,
madinah_travel_date, madinah_hotel, madinah_floor, madinah_room,
departure_airport, departure_airline, departure_flight_no, departure_date, departure_time,
return_airport, return_airline, return_flight_no, return_date, return_time,
service_center_name, service_center_arafat, service_center_mina,
bus_arafat, bus_mina, tent_arafat, tent_mina,
phone_number, whatsapp_number, syrian_phone_number, notes,
field_status, medical_test_status, travel_date, hotel_name, hotel_location_url,
transportation_details, profile_id
''';
}
