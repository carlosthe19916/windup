<#if index_page??>
    <#assign redHatLogoPrefix = navUrlPrefix>
<#else>
    <#assign redHatLogoPrefix = "">
</#if>
            <div class="pf-c-page__header-brand">
                <a class="pf-c-page__header-brand-link">
<#--                    <img class="pf-c-brand" src="${redHatLogoPrefix}resources/img/Logo-RedHat-A-Reverse-RGB.png" alt="Logo">-->
                    <img class="pf-c-brand" src="${redHatLogoPrefix}resources/img/patternfly-logo.svg" alt="Logo">
                </a>
            </div>