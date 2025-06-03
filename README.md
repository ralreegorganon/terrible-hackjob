Do a `docker compose up --build`

See output like follows:
```
data_importer  | Waiting for PostGIS to be ready...
data_importer  | PostGIS is ready!
data_importer  | Importing CityBoundaries...
data_importer  | 0...10...20...30...40...50...60...70...80...90...100 - done.
data_importer  | Successfully imported CityBoundaries
data_importer  | Importing CSV: 500_Cities__City-level_Data__GIS_Friendly_Format___2019_release_20250522...
data_importer  | Warning 6: Progress turned off as fast feature count is not available.
data_importer  | Warning 1: 500_Cities__City-level_Data__GIS_Friendly_Format___2019_release_20250522 identifier truncated to 500_cities__city_level_data__gis_friendly_format___201_8dedef57
data_importer  | Successfully imported CSV: 500_Cities__City-level_Data__GIS_Friendly_Format___2019_release_20250522
data_importer  | All imports completed!

```

Connect to PostGIS with the tool of your choice.