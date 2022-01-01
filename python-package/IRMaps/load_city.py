import os
from IRMaps.utils import load_map


def load_city():
    """ Load Iran citys map as a geoDataFrame object.
    This map contains iran 2018 official cities' division.

    Parameters
    ----------

    Returns
    -------
    geopandas.GeoDataFrame
        Metadata and geometry of iran's cities

    Raises
    ------
    Exception
        If parameters are not found or not well-defined
    Example
    -------
    >>> from IRMaps import load_city
    >>> city_map = load_city
    """
    location = os.path.dirname(os.path.realpath(__file__))
    path = os.path.join(location, 'data', 'city.geojson')
    return load_map(path)
