class Country {
  final String code;
  final String name;

  Country({required this.code, required this.name});

  static List<Country> get countries => [
        Country(code: 'US', name: 'United States'),
        Country(code: 'GB', name: 'United Kingdom'),
        Country(code: 'AE', name: 'United Arab Emirates'),
        Country(code: 'PK', name: 'Pakistan'),
        Country(code: 'IN', name: 'India'),
        Country(code: 'CN', name: 'China'),
        Country(code: 'SA', name: 'Saudi Arabia'),
        Country(code: 'CA', name: 'Canada'),
        Country(code: 'AU', name: 'Australia'),
        Country(code: 'DE', name: 'Germany'),
        Country(code: 'FR', name: 'France'),
        Country(code: 'IT', name: 'Italy'),
        Country(code: 'ES', name: 'Spain'),
        Country(code: 'NL', name: 'Netherlands'),
        Country(code: 'BE', name: 'Belgium'),
        Country(code: 'SE', name: 'Sweden'),
        Country(code: 'NO', name: 'Norway'),
        Country(code: 'DK', name: 'Denmark'),
        Country(code: 'FI', name: 'Finland'),
        Country(code: 'JP', name: 'Japan'),
        Country(code: 'KR', name: 'South Korea'),
        Country(code: 'SG', name: 'Singapore'),
        Country(code: 'MY', name: 'Malaysia'),
        Country(code: 'TH', name: 'Thailand'),
        Country(code: 'VN', name: 'Vietnam'),
        Country(code: 'PH', name: 'Philippines'),
        Country(code: 'ID', name: 'Indonesia'),
        Country(code: 'BD', name: 'Bangladesh'),
        Country(code: 'LK', name: 'Sri Lanka'),
        Country(code: 'NP', name: 'Nepal'),
      ];

  @override
  String toString() => name;
}
