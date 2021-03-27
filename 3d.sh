#!/bin/bash

Now="%d%m%Y"
Password=$(date +"$Now")
zip -P $"Password" -r -m Koleksi.zip ./Kelinci* ./Kucing*

