import os
from IRMaps.utils import load_map


def load_district():
    """ Load Iran districts map as a geoDataFrame object.
    This map contains iran 2018 official districts' division.

    Parameters
    ----------

    Returns
    -------
    geopandas.GeoDataFrame
        Metadata and geometry of iran's districts

    Raises
    ------
    Exception
        If parameters are not found or not well-defined
    Example
    -------
    >>> from IRMaps import load_district
    >>> district_map = load_district
    """
    location = os.path.dirname(os.path.realpath(__file__))
    path = os.path.join(location, 'data', 'district.geojson')
    return load_map(path)
