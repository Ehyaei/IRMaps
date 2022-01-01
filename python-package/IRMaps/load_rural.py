import os
from IRMaps.utils import load_map


def load_rural():
    """ Load Iran rurals map as a geoDataFrame object.
    This map contains iran 2018 official rurals' division.

    Parameters
    ----------

    Returns
    -------
    geopandas.GeoDataFrame
        Metadata and geometry of iran's rurals

    Raises
    ------
    Exception
        If parameters are not found or not well-defined
    Example
    -------
    >>> from IRMaps import load_rural
    >>> rural_map = load_rural
    """
    location = os.path.dirname(os.path.realpath(__file__))
    path = os.path.join(location, 'data', 'rural.geojson')
    return load_map(path)
