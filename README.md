# EndNote to RIS converter

I needed an automated way to convert from EndNote xml format to RIS, hence this xsl template.

## How to run

Install saxon (XSLT 2.0 processor). On Ubuntu:

    sudo apt-get install libsaxon-java

Then run:
    saxon-xslt My\ Collection.xml endNote2RIS.xsl > exported.ris

## Shortcomings

The path to PDF files is hardcoded. It points to the PDF directory of EndNote. It would be better
to extract it as a parameter. Please submit a patch if you do. Thanks. :-)
