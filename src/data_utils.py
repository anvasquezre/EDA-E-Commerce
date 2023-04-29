import os
import gdown
import pandas as pd
from src import config
from pathlib import Path
from zipfile import ZipFile

def get_datasets():
    """
    Download from GDrive all the needed datasets for the project.

    """
    os.makedirs(config.DATASET_ROOT_PATH, exist_ok=True)
    # Download dataset from google drive.csv
    data_mapping = config.get_csv_to_table_mapping()
    
    if not os.path.exists(config.DATASET_ZIP_PATH):
        
        gdown.download(
            config.DATA_URL, config.DATASET_ZIP_PATH, quiet=False
    )
    else:
        print('Zip already downloaded')
        
    for data_path,name in data_mapping.items():
        
        if not os.path.exists(str(Path(config.DATASET_ROOT_PATH, data_path))):

            with ZipFile(config.DATASET_ZIP_PATH, 'r') as zip_ref:
                zip_ref.extractall(path=config.DATASET_ROOT_PATH, members=[data_path])
            print(f'Dataset {data_path}  retrieved succesfully')
        else:
            print(f"Dataset {data_path} already exists")
    
    return