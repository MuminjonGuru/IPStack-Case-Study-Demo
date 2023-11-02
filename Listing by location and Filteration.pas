type
  TListing = record
    ID: Integer;
    Title: string;
    Description: string;
    Category: string;  // e.g., "Adventure", "Nature", "Cultural", "Social Impact"
    Geography: string;  // e.g., "Urban", "Rural", "Mountain", "Beach"
    GPSLatitude: Double;
    GPSLongitude: Double;
    Type: string;  // e.g., "Regular", "Beyond", "Plus"
  end;
 
const
  SampleListings: array[1..5] of TListing = (
    (ID: 1; Title: 'Mountain Retreat'; Description: 'A cozy cabin in the mountains.'; Category: 'Nature'; Geography: 'Mountain'; GPSLatitude: 37.7749; GPSLongitude: -122.4194; Type: 'Regular'),
    (ID: 2; Title: 'Beach Bungalow'; Description: 'A relaxing beachfront property.'; Category: 'Adventure'; Geography: 'Beach'; GPSLatitude: 34.0522; GPSLongitude: -118.2437; Type: 'Plus'),
    (ID: 3; Title: 'City Loft'; Description: 'A modern loft in the heart of the city.'; Category: 'Cultural'; Geography: 'Urban'; GPSLatitude: 40.7128; GPSLongitude: -74.0060; Type: 'Regular'),
    (ID: 4; Title: 'Rural Farmstay'; Description: 'Experience farm life in the countryside.'; Category: 'Social Impact'; Geography: 'Rural'; GPSLatitude: 51.5074; GPSLongitude: -0.1278; Type: 'Beyond'),
    (ID: 5; Title: 'Environmental Retreat'; Description: 'Engage with nature and support local conservation.'; Category: 'Nature'; Geography: 'Forest'; GPSLatitude: 48.8566; GPSLongitude: 2.3522; Type: 'Social Impact')
  );
...
...
...
..
.
..
...
...
...
function SearchListingsByLocation(GPSLat: Double; GPSLon: Double; SearchRadius: Double): TArray<TListing>;
begin
  // Here, you'd search the listings based on the given GPS coordinates and return those within the specified radius.
  // For simplicity, this mock function returns all sample listings.
  Result := SampleListings;
end;
 
function ExploreOrDiscoverByCategory(Category: string; Geography: string): TArray<TListing>;
begin
  //
