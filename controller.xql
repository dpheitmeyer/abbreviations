xquery version "3.0";

(: External variables available to the controller: :)
declare variable $exist:path external;
declare variable $exist:resource external;
declare variable $exist:controller external;
declare variable $exist:root external;
declare variable $exist:prefix external;

(: Other variables :)
declare variable $home-page-url := "index.html";
declare variable $collection_path := concat($exist:root, '/', $exist:controller, '/data/');

(: If trailing slash is missing, put it there and redirect :)
if($exist:path eq "") then
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="{request:get-uri()}/"/>
    </dispatch>
    
(: If there is no resource specified, go to the home page.
This is a redirect, forcing the browser to perform a redirect. So this request
will pass through the controller again... :)
else if($exist:resource eq "") then
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="{$home-page-url}"/>
    </dispatch>

else if($exist:resource eq $home-page-url) then
    <dispatch
        xmlns="http://exist.sourceforge.net/NS/exist">
        <forward
            url="{$exist:controller}/xquery/abbreviations.xq">
            <set-attribute
                name="collection_path"
                value="{$collection_path}"/>
        </forward>  
        <view>
            <forward
                servlet="XSLTServlet">
                <set-attribute
                    name="xslt.stylesheet"
                    value="{concat($exist:root, $exist:controller, "/xsl/acronyms.xsl")}"/>
            </forward>
        </view>
    </dispatch>

else if($exist:resource eq 'new') then
    <dispatch
        xmlns="http://exist.sourceforge.net/NS/exist">
        <forward
            url="{$exist:controller}/xforms/edit-abbreviation.html">
        </forward>  
    </dispatch>
    
else if($exist:resource eq 'submit') then
    <dispatch
        xmlns="http://exist.sourceforge.net/NS/exist">
        <forward
            url="{$exist:controller}/xquery/submit.xq">
            <set-attribute
                name="collection_path"
                value="{$collection_path}"/>
        </forward>  
        <view>
            <forward
                servlet="XSLTServlet">
                <set-attribute
                    name="xslt.stylesheet"
                    value="{concat($exist:root, $exist:controller, "/xsl/acronyms.xsl")}"/>
            </forward>
        </view>
    </dispatch>
    
(: Anything else, pass through: :)
else
    <ignore xmlns="http://exist.sourceforge.net/NS/exist">
        <cache-control cache="yes"/> 
    </ignore>