from typing import Dict

import requests
from pandas import DataFrame, read_csv, read_json, to_datetime


def get_public_holidays(public_holidays_url: str, year: str) -> DataFrame:

    # Building URL str
    requests_url = f"{public_holidays_url}/{year}/BR"
    
    try:
        # Requesting Data to URL
        response = requests.get(requests_url)
        # Checking HTTP Status
        response.raise_for_status()
        # No error raises, then continue saving Response as DataFrame
        df = DataFrame(response.json())
        # If no JSON error, then continue.
    # Checking for any error not only HTTPError
    except requests.exceptions.RequestException as e:
        error_msg = f"Error retrieving data from {public_holidays_url}: {str(e)}"
        # Raising SystemExit (SystemExit not handled in this function)
        raise SystemExit(error_msg)

    # Droping "counties" and "types" columns
    df.drop(['counties', 'types'], axis=1, inplace=True)
    # Transforming type == object to DateTime
    df['date'] = to_datetime(df['date'])

    return df


def extract(
    csv_folder: str, csv_table_mapping: Dict[str, str], public_holidays_url: str
) -> Dict[str, DataFrame]:
    """Extract the data from the csv files and load them into the dataframes.
    Args:
        csv_folder (str): The path to the csv's folder.
        csv_table_mapping (Dict[str, str]): The mapping of the csv file names to the
        table names.
        public_holidays_url (str): The url to the public holidays.
    Returns:
        Dict[str, DataFrame]: A dictionary with keys as the table names and values as
        the dataframes.
    """
    dataframes = {
        table_name: read_csv(f"{csv_folder}/{csv_file}")
        for csv_file, table_name in csv_table_mapping.items()
    }

    holidays = get_public_holidays(public_holidays_url, "2017")

    dataframes["public_holidays"] = holidays

    return dataframes
