import geopandas


def load_map(path):
    """Internal function to read geojson file from package and convert to geopandas .

        ----------
        path : str
            Address with geojson
        Returns
        -------
        geopandas.GeoDataFrame
             Table with metadata and shapefiles.
        """
    geoMap = geopandas.read_file(path)
    geoMap = geoMap.to_crs(epsg=4326)
    return geoMap
