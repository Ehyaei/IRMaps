import os
from IRMaps.utils import load_map


def load_feature():
    """ Load Iran features map as a geoDataFrame object.
    This map contains iran 2018 official features' division.

    Parameters
    ----------

    Returns
    -------
    geopandas.GeoDataFrame
        Metadata and geometry of iran's features

    Raises
    ------
    Exception
        If parameters are not found or not well-defined
    Example
    -------
    >>> from IRMaps import load_feature
    >>> feature_map = load_feature
    """
    location = os.path.dirname(os.path.realpath(__file__))
    path = os.path.join(location, 'data', 'feature.geojson')
    return load_map(path)
