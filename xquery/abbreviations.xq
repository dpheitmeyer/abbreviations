xquery version "3.0" encoding "UTF-8";

declare variable $col_path := request:get-attribute('collection_path');
declare variable $col := collection($col_path);

<data>
    {
        for $e in $col/entry
        order by $e/abbreviation
        return $e
    }
</data>