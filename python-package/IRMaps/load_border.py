import os
from IRMaps.utils import load_map


def load_border():
    """ Load Iran borders map as a geoDataFrame object.
    This map contains iran 2018 official borders' division.

    Parameters
    ----------

    Returns
    -------
    geopandas.GeoDataFrame
        Metadata and geometry of iran's borders

    Raises
    ------
    Exception
        If parameters are not found or not well-defined
    Example
    -------
    >>> from IRMaps import load_border
    >>> border_map = load_border
    """
    location = os.path.dirname(os.path.realpath(__file__))
    path = os.path.join(location, 'data', 'border.geojson')
    return load_map(path)
