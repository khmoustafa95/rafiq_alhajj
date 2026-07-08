import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Which physical table a pilgrim field is persisted to.
enum PilgrimFieldTable { person, enrollment }

/// How a pilgrim field is rendered and (de)serialized.
enum PilgrimFieldKind { text, multiline, url, phone, date, boolean, gender }

/// A single pilgrim field: its form-control name (== DB column), the table it
/// belongs to, how to render it, and a localized label.
///
/// This is the single source of truth shared by the intake form, the edit
/// form, and the person/enrollment payload builders (DRY).
class PilgrimField {
  const PilgrimField({
    required this.key,
    required this.table,
    required this.label,
    this.kind = PilgrimFieldKind.text,
    this.icon,
    this.required = false,
    this.shared = false,
  });

  /// Form control name and Supabase column name (kept identical on purpose).
  final String key;
  final PilgrimFieldTable table;
  final String Function(AppLocalizations) label;
  final PilgrimFieldKind kind;
  final IconData? icon;
  final bool required;

  /// Whether this field is a good candidate for the reusable "shared defaults"
  /// (logistics commonly identical across a batch of pilgrims).
  final bool shared;
}

/// A titled group of [PilgrimField]s.
class PilgrimFieldSection {
  const PilgrimFieldSection({
    required this.title,
    required this.icon,
    required this.fields,
  });

  final String Function(AppLocalizations) title;
  final IconData icon;
  final List<PilgrimField> fields;
}

/// The full pilgrim field catalog, grouped into logical sections.
const List<PilgrimFieldSection> pilgrimFieldSections = [
  PilgrimFieldSection(
    title: _identityTitle,
    icon: Icons.badge_outlined,
    fields: [
      PilgrimField(
        key: 'full_name_ar',
        table: PilgrimFieldTable.person,
        label: _fullNameAr,
        icon: Icons.person_outline,
        required: true,
      ),
      PilgrimField(
        key: 'mother_name_ar',
        table: PilgrimFieldTable.person,
        label: _motherAr,
      ),
      PilgrimField(
        key: 'gender',
        table: PilgrimFieldTable.person,
        label: _gender,
        kind: PilgrimFieldKind.gender,
        icon: Icons.wc_outlined,
      ),
      PilgrimField(
        key: 'birth_date',
        table: PilgrimFieldTable.person,
        label: _birthDate,
        icon: Icons.cake_outlined,
      ),
      PilgrimField(
        key: 'first_name_en',
        table: PilgrimFieldTable.person,
        label: _firstNameEn,
      ),
      PilgrimField(
        key: 'last_name_en',
        table: PilgrimFieldTable.person,
        label: _lastNameEn,
      ),
      PilgrimField(
        key: 'father_name_en',
        table: PilgrimFieldTable.person,
        label: _fatherEn,
      ),
      PilgrimField(
        key: 'mother_name_en',
        table: PilgrimFieldTable.person,
        label: _motherEn,
      ),
      PilgrimField(
        key: 'body_size',
        table: PilgrimFieldTable.person,
        label: _bodySize,
      ),
      PilgrimField(
        key: 'residence',
        table: PilgrimFieldTable.person,
        label: _residence,
        icon: Icons.location_on_outlined,
      ),
    ],
  ),
  PilgrimFieldSection(
    title: _travelDocsTitle,
    icon: Icons.card_travel_outlined,
    fields: [
      PilgrimField(
        key: 'passport_number',
        table: PilgrimFieldTable.person,
        label: _passport,
        icon: Icons.credit_card_outlined,
      ),
      PilgrimField(
        key: 'passport_issue_date',
        table: PilgrimFieldTable.person,
        label: _passportIssue,
      ),
      PilgrimField(
        key: 'passport_expiry_date',
        table: PilgrimFieldTable.person,
        label: _passportExpiry,
      ),
      PilgrimField(
        key: 'travel_permit_number',
        table: PilgrimFieldTable.enrollment,
        label: _travelPermit,
        icon: Icons.assignment_outlined,
      ),
      PilgrimField(
        key: 'visa_number',
        table: PilgrimFieldTable.enrollment,
        label: _visa,
      ),
      PilgrimField(
        key: 'sticker_number',
        table: PilgrimFieldTable.enrollment,
        label: _sticker,
      ),
      PilgrimField(
        key: 'barcode_number',
        table: PilgrimFieldTable.enrollment,
        label: _barcode,
      ),
    ],
  ),
  PilgrimFieldSection(
    title: _registrationTitle,
    icon: Icons.fact_check_outlined,
    fields: [
      PilgrimField(
        key: 'sequence',
        table: PilgrimFieldTable.enrollment,
        label: _sequence,
      ),
      PilgrimField(
        key: 'cluster',
        table: PilgrimFieldTable.enrollment,
        label: _cluster,
        shared: true,
      ),
      PilgrimField(
        key: 'coordinator_name',
        table: PilgrimFieldTable.enrollment,
        label: _coordinator,
        shared: true,
      ),
      PilgrimField(
        key: 'companion_name',
        table: PilgrimFieldTable.enrollment,
        label: _companion,
      ),
      PilgrimField(
        key: 'relation',
        table: PilgrimFieldTable.enrollment,
        label: _relation,
      ),
      PilgrimField(
        key: 'request_type',
        table: PilgrimFieldTable.enrollment,
        label: _requestType,
        shared: true,
      ),
      PilgrimField(
        key: 'housing_type',
        table: PilgrimFieldTable.enrollment,
        label: _housingType,
        shared: true,
      ),
      PilgrimField(
        key: 'hady_status',
        table: PilgrimFieldTable.enrollment,
        label: _hadyStatus,
        shared: true,
      ),
    ],
  ),
  PilgrimFieldSection(
    title: _healthTitle,
    icon: Icons.health_and_safety_outlined,
    fields: [
      PilgrimField(
        key: 'health_status',
        table: PilgrimFieldTable.enrollment,
        label: _healthStatus,
      ),
      PilgrimField(
        key: 'medical_test_status',
        table: PilgrimFieldTable.enrollment,
        label: _medical,
        icon: Icons.medical_services_outlined,
      ),
      PilgrimField(
        key: 'needs_wheelchair',
        table: PilgrimFieldTable.enrollment,
        label: _wheelchair,
        kind: PilgrimFieldKind.boolean,
      ),
      PilgrimField(
        key: 'is_smoking',
        table: PilgrimFieldTable.enrollment,
        label: _smoking,
        kind: PilgrimFieldKind.boolean,
      ),
      PilgrimField(
        key: 'health_card',
        table: PilgrimFieldTable.enrollment,
        label: _healthCard,
        kind: PilgrimFieldKind.boolean,
      ),
      PilgrimField(
        key: 'is_vaccinated',
        table: PilgrimFieldTable.enrollment,
        label: _vaccinated,
        kind: PilgrimFieldKind.boolean,
      ),
    ],
  ),
  PilgrimFieldSection(
    title: _logisticsTitle,
    icon: Icons.flight_takeoff_outlined,
    fields: [
      PilgrimField(
        key: 'travel_date',
        table: PilgrimFieldTable.enrollment,
        label: _travelDate,
        kind: PilgrimFieldKind.date,
        shared: true,
      ),
      PilgrimField(
        key: 'hotel_name',
        table: PilgrimFieldTable.enrollment,
        label: _hotel,
        icon: Icons.hotel_outlined,
        shared: true,
      ),
      PilgrimField(
        key: 'hotel_location_url',
        table: PilgrimFieldTable.enrollment,
        label: _hotelUrl,
        kind: PilgrimFieldKind.url,
        icon: Icons.map_outlined,
        shared: true,
      ),
      PilgrimField(
        key: 'transportation_details',
        table: PilgrimFieldTable.enrollment,
        label: _transport,
        icon: Icons.directions_bus_outlined,
        shared: true,
      ),
    ],
  ),
  PilgrimFieldSection(
    title: _makkahTitle,
    icon: Icons.location_city_outlined,
    fields: [
      PilgrimField(
        key: 'makkah_hotel',
        table: PilgrimFieldTable.enrollment,
        label: _makkahHotel,
        shared: true,
      ),
      PilgrimField(
        key: 'makkah_floor',
        table: PilgrimFieldTable.enrollment,
        label: _makkahFloor,
      ),
      PilgrimField(
        key: 'makkah_room',
        table: PilgrimFieldTable.enrollment,
        label: _makkahRoom,
      ),
    ],
  ),
  PilgrimFieldSection(
    title: _madinahTitle,
    icon: Icons.mosque_outlined,
    fields: [
      PilgrimField(
        key: 'madinah_travel_date',
        table: PilgrimFieldTable.enrollment,
        label: _madinahTravel,
        shared: true,
      ),
      PilgrimField(
        key: 'madinah_hotel',
        table: PilgrimFieldTable.enrollment,
        label: _madinahHotel,
        shared: true,
      ),
      PilgrimField(
        key: 'madinah_floor',
        table: PilgrimFieldTable.enrollment,
        label: _madinahFloor,
      ),
      PilgrimField(
        key: 'madinah_room',
        table: PilgrimFieldTable.enrollment,
        label: _madinahRoom,
      ),
    ],
  ),
  PilgrimFieldSection(
    title: _departureTitle,
    icon: Icons.flight_takeoff,
    fields: [
      PilgrimField(
        key: 'departure_airport',
        table: PilgrimFieldTable.enrollment,
        label: _departureAirport,
        shared: true,
      ),
      PilgrimField(
        key: 'departure_airline',
        table: PilgrimFieldTable.enrollment,
        label: _departureAirline,
        shared: true,
      ),
      PilgrimField(
        key: 'departure_flight_no',
        table: PilgrimFieldTable.enrollment,
        label: _departureFlight,
        shared: true,
      ),
      PilgrimField(
        key: 'departure_date',
        table: PilgrimFieldTable.enrollment,
        label: _departureDate,
        shared: true,
      ),
      PilgrimField(
        key: 'departure_time',
        table: PilgrimFieldTable.enrollment,
        label: _departureTime,
        shared: true,
      ),
    ],
  ),
  PilgrimFieldSection(
    title: _returnTitle,
    icon: Icons.flight_land,
    fields: [
      PilgrimField(
        key: 'return_airport',
        table: PilgrimFieldTable.enrollment,
        label: _returnAirport,
        shared: true,
      ),
      PilgrimField(
        key: 'return_airline',
        table: PilgrimFieldTable.enrollment,
        label: _returnAirline,
        shared: true,
      ),
      PilgrimField(
        key: 'return_flight_no',
        table: PilgrimFieldTable.enrollment,
        label: _returnFlight,
        shared: true,
      ),
      PilgrimField(
        key: 'return_date',
        table: PilgrimFieldTable.enrollment,
        label: _returnDate,
        shared: true,
      ),
      PilgrimField(
        key: 'return_time',
        table: PilgrimFieldTable.enrollment,
        label: _returnTime,
        shared: true,
      ),
    ],
  ),
  PilgrimFieldSection(
    title: _holySitesTitle,
    icon: Icons.temple_buddhist_outlined,
    fields: [
      PilgrimField(
        key: 'service_center_name',
        table: PilgrimFieldTable.enrollment,
        label: _serviceCenter,
        shared: true,
      ),
      PilgrimField(
        key: 'service_center_arafat',
        table: PilgrimFieldTable.enrollment,
        label: _centerArafat,
        shared: true,
      ),
      PilgrimField(
        key: 'service_center_mina',
        table: PilgrimFieldTable.enrollment,
        label: _centerMina,
        shared: true,
      ),
      PilgrimField(
        key: 'bus_arafat',
        table: PilgrimFieldTable.enrollment,
        label: _busArafat,
        shared: true,
      ),
      PilgrimField(
        key: 'bus_mina',
        table: PilgrimFieldTable.enrollment,
        label: _busMina,
        shared: true,
      ),
      PilgrimField(
        key: 'tent_arafat',
        table: PilgrimFieldTable.enrollment,
        label: _tentArafat,
        shared: true,
      ),
      PilgrimField(
        key: 'tent_mina',
        table: PilgrimFieldTable.enrollment,
        label: _tentMina,
        shared: true,
      ),
    ],
  ),
  PilgrimFieldSection(
    title: _contactTitle,
    icon: Icons.phone_outlined,
    fields: [
      PilgrimField(
        key: 'phone_number',
        table: PilgrimFieldTable.person,
        label: _phone,
        kind: PilgrimFieldKind.phone,
        icon: Icons.call_outlined,
      ),
      PilgrimField(
        key: 'whatsapp_number',
        table: PilgrimFieldTable.person,
        label: _whatsapp,
        kind: PilgrimFieldKind.phone,
        icon: Icons.chat_outlined,
      ),
      PilgrimField(
        key: 'syrian_phone_number',
        table: PilgrimFieldTable.person,
        label: _syrianPhone,
        kind: PilgrimFieldKind.phone,
        icon: Icons.call_outlined,
      ),
    ],
  ),
  PilgrimFieldSection(
    title: _notesTitle,
    icon: Icons.notes_outlined,
    fields: [
      PilgrimField(
        key: 'notes',
        table: PilgrimFieldTable.enrollment,
        label: _notes,
        kind: PilgrimFieldKind.multiline,
      ),
    ],
  ),
];

/// Flattened view of every catalog field.
final List<PilgrimField> pilgrimFields = [
  for (final section in pilgrimFieldSections) ...section.fields,
];

// --- Label resolvers (reuse existing l10n keys) -----------------------------

String _identityTitle(AppLocalizations l) => l.pilgrimSectionIdentity;
String _travelDocsTitle(AppLocalizations l) => l.pilgrimSectionTravelDocs;
String _registrationTitle(AppLocalizations l) => l.pilgrimSectionPersonal;
String _healthTitle(AppLocalizations l) => l.pilgrimSectionHealth;
String _logisticsTitle(AppLocalizations l) => l.pilgrimLogisticsTitle;
String _makkahTitle(AppLocalizations l) => l.pilgrimSectionMakkah;
String _madinahTitle(AppLocalizations l) => l.pilgrimSectionMadinah;
String _departureTitle(AppLocalizations l) => l.pilgrimSectionDepartureFlight;
String _returnTitle(AppLocalizations l) => l.pilgrimSectionReturnFlight;
String _holySitesTitle(AppLocalizations l) => l.pilgrimSectionHolySites;
String _contactTitle(AppLocalizations l) => l.pilgrimSectionContact;
String _notesTitle(AppLocalizations l) => l.pilgrimSectionNotes;

String _fullNameAr(AppLocalizations l) => l.pilgrimLabelFullNameAr;
String _motherAr(AppLocalizations l) => l.pilgrimLabelMotherAr;
String _gender(AppLocalizations l) => l.pilgrimLabelGender;
String _birthDate(AppLocalizations l) => l.pilgrimLabelBirthDate;
String _firstNameEn(AppLocalizations l) => l.pilgrimLabelFirstNameEn;
String _lastNameEn(AppLocalizations l) => l.pilgrimLabelLastNameEn;
String _fatherEn(AppLocalizations l) => l.pilgrimLabelFatherEn;
String _motherEn(AppLocalizations l) => l.pilgrimLabelMotherEn;
String _bodySize(AppLocalizations l) => l.pilgrimLabelBodySize;
String _residence(AppLocalizations l) => l.pilgrimLabelResidence;
String _passport(AppLocalizations l) => l.operatorPassport;
String _passportIssue(AppLocalizations l) => l.pilgrimLabelPassportIssue;
String _passportExpiry(AppLocalizations l) => l.pilgrimLabelPassportExpiry;
String _travelPermit(AppLocalizations l) => l.operatorTravelPermit;
String _visa(AppLocalizations l) => l.pilgrimLabelVisa;
String _sticker(AppLocalizations l) => l.pilgrimLabelSticker;
String _barcode(AppLocalizations l) => l.pilgrimLabelBarcode;
String _sequence(AppLocalizations l) => l.pilgrimLabelSequence;
String _cluster(AppLocalizations l) => l.pilgrimLabelCluster;
String _coordinator(AppLocalizations l) => l.pilgrimLabelCoordinator;
String _companion(AppLocalizations l) => l.pilgrimLabelCompanion;
String _relation(AppLocalizations l) => l.pilgrimLabelRelation;
String _requestType(AppLocalizations l) => l.pilgrimLabelRequestType;
String _housingType(AppLocalizations l) => l.pilgrimLabelHousingType;
String _hadyStatus(AppLocalizations l) => l.pilgrimLabelHadyStatus;
String _healthStatus(AppLocalizations l) => l.pilgrimLabelHealthStatus;
String _medical(AppLocalizations l) => l.pilgrimMedicalStatus;
String _wheelchair(AppLocalizations l) => l.pilgrimLabelWheelchair;
String _smoking(AppLocalizations l) => l.pilgrimLabelSmoking;
String _healthCard(AppLocalizations l) => l.pilgrimLabelHealthCard;
String _vaccinated(AppLocalizations l) => l.pilgrimLabelVaccinated;
String _travelDate(AppLocalizations l) => l.pilgrimTravelDate;
String _hotel(AppLocalizations l) => l.pilgrimHotel;
String _hotelUrl(AppLocalizations l) => l.operatorHotelMapUrl;
String _transport(AppLocalizations l) => l.pilgrimTransport;
String _makkahHotel(AppLocalizations l) => l.pilgrimLabelMakkahHotel;
String _makkahFloor(AppLocalizations l) => l.pilgrimLabelMakkahFloor;
String _makkahRoom(AppLocalizations l) => l.pilgrimLabelMakkahRoom;
String _madinahTravel(AppLocalizations l) => l.pilgrimLabelMadinahTravel;
String _madinahHotel(AppLocalizations l) => l.pilgrimLabelMadinahHotel;
String _madinahFloor(AppLocalizations l) => l.pilgrimLabelMadinahFloor;
String _madinahRoom(AppLocalizations l) => l.pilgrimLabelMadinahRoom;
String _departureAirport(AppLocalizations l) => l.pilgrimLabelDepartureAirport;
String _departureAirline(AppLocalizations l) => l.pilgrimLabelDepartureAirline;
String _departureFlight(AppLocalizations l) => l.pilgrimLabelDepartureFlight;
String _departureDate(AppLocalizations l) => l.pilgrimLabelDepartureDate;
String _departureTime(AppLocalizations l) => l.pilgrimLabelDepartureTime;
String _returnAirport(AppLocalizations l) => l.pilgrimLabelReturnAirport;
String _returnAirline(AppLocalizations l) => l.pilgrimLabelReturnAirline;
String _returnFlight(AppLocalizations l) => l.pilgrimLabelReturnFlight;
String _returnDate(AppLocalizations l) => l.pilgrimLabelReturnDate;
String _returnTime(AppLocalizations l) => l.pilgrimLabelReturnTime;
String _serviceCenter(AppLocalizations l) => l.pilgrimLabelServiceCenter;
String _centerArafat(AppLocalizations l) => l.pilgrimLabelCenterArafat;
String _centerMina(AppLocalizations l) => l.pilgrimLabelCenterMina;
String _busArafat(AppLocalizations l) => l.pilgrimLabelBusArafat;
String _busMina(AppLocalizations l) => l.pilgrimLabelBusMina;
String _tentArafat(AppLocalizations l) => l.pilgrimLabelTentArafat;
String _tentMina(AppLocalizations l) => l.pilgrimLabelTentMina;
String _phone(AppLocalizations l) => l.pilgrimLabelPhone;
String _whatsapp(AppLocalizations l) => l.pilgrimLabelWhatsapp;
String _syrianPhone(AppLocalizations l) => l.pilgrimLabelSyrianPhone;
String _notes(AppLocalizations l) => l.pilgrimSectionNotes;
