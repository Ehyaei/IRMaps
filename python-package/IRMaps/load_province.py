import os
from IRMaps.utils import load_map


def load_province():
    """ Load Iran provinces map as a geoDataFrame object.
    This map contains iran 2018 official provinces' division.

    Parameters
    ----------

    Returns
    -------
    geopandas.GeoDataFrame
        Metadata and geometry of iran's provinces

    Raises
    ------
    Exception
        If parameters are not found or not well-defined
    Example
    -------
    >>> from IRMaps import load_province
    >>> province_map = load_province
    """
    location = os.path.dirname(os.path.realpath(__file__))
    path = os.path.join(location, 'data', 'province.geojson')
    return load_map(path)
