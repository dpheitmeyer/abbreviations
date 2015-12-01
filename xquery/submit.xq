xquery version "1.0";
import module namespace request = "http://exist-db.org/xquery/request";
import module namespace xmldb = "http://exist-db.org/xquery/xmldb";
let $doc-db-uri := xmldb:store("/db/apps/abbreviations/data",
(),
request:get-data())
return
    <stored>    
        <dbUri>{$doc-db-uri}</dbUri>
        <uri>http://{request:get-server-name()}:{request:get-server-port()}
            {request:get-context-path()}/rest{$doc-db-uri}</uri>
    </stored>