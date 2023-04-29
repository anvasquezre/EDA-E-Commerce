from typing import Dict

from pandas import DataFrame
from sqlalchemy.engine.base import Engine


def load(data_frames: Dict[str, DataFrame], database: Engine):

    con = database.connect()

    for key,value in data_frames.items():

        df = value
        df.to_sql(key, con, if_exists='replace',index=False)
