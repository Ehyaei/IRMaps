import os
from IRMaps.utils import load_map


def load_county():
    """ Load Iran countys map as a geoDataFrame object.
    This map contains iran 2018 official counties' division.

    Parameters
    ----------

    Returns
    -------
    geopandas.GeoDataFrame
        Metadata and geometry of iran's counties

    Raises
    ------
    Exception
        If parameters are not found or not well-defined
    Example
    -------
    >>> from IRMaps import load_county
    >>> county_map = load_county
    """
    location = os.path.dirname(os.path.realpath(__file__))
    path = os.path.join(location, 'data', 'county.geojson')
    return load_map(path)
