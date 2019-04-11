<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" indent="no" encoding="utf-8" doctype-system="about:legacy-compat"/>

  <xsl:template match="/control/layout">
    <html>
      <head>
        <meta charset="utf-8"/>
        <title>Apical Control Tool</title>
        <link rel="shortcut icon" type="image/png" href="/img/acs.png"/>
        <link rel="icon" type="image/png" href="/img/acs.png"/>
        <link rel="stylesheet" type="text/css" href="css/acs.min.css"/>
      </head>
      <body>

        <header class="toolbar">

          <div class="tab-switch">
            <input id="hw-tab" checked="" name="tabs" type="radio" class="tab-radio" value="hw"/>
            <label for="hw-tab" class="tab-label">Hardware</label>
            <input id="api-tab" name="tabs" type="radio" class="tab-radio" value="api"/>
            <label for="api-tab" class="tab-label hidden">API</label>
            <input id="static-tab" name="tabs" type="radio" class="tab-radio" value="static"/>
            <label for="static-tab" class="tab-label hidden">Static Calibrations</label>
            <input id="dynamic-tab" name="tabs" type="radio" class="tab-radio" value="dynamic"/>
            <label for="dynamic-tab" class="tab-label hidden">Dynamic Calibrations</label>
            <input id="file-tab" name="tabs" type="radio" class="tab-radio" value="file"/>
            <label for="file-tab" class="tab-label hidden">File Transfer</label>
          </div>

          <div class="main-search-holder">
            <i class="foundicon-search"/>
            <input id="reg-search" type="text" spellcheck="false" class="search"/>
            <i id="clear-reg-search" class="foundicon-remove clear-search search-hidden" tooltip="Clear search query"/>
          </div>

          <i id="read-all-button" class="toolbar-button foundicon-refresh" tooltip="Read all shown registers"/>
          <i id="toggle-fav-button" class="toolbar-button disabled foundicon-star star-selected" tooltip="Toggle show/hide favourites"/>
          <i id="stop-polling-button" class="toolbar-button disabled foundicon-x-stop" tooltip="Stop automatic reloading"/>
          <i id="polling-counter" class="toolbar-text"/>
          <i id="options-menu-button" class="toolbar-button foundicon-menu"/>

          <div id="options-menu" class="hidden options-menu">
            <ul>
              <li id="open-settings" class="opt-menu-item">Edit ACT settings</li>
              <li class="menu-delimiter"/>
              <li id="load-hw-registers" class="opt-menu-item">Load HW registers</li>
              <li class="menu-delimiter"/>
              <li id="save-hw-registers" class="opt-menu-item">Save all HW registers</li>
              <li id="save-visible-hw-registers" class="opt-menu-item">Save visible HW registers</li>
              <li class="menu-delimiter"/>
              <li id="save-static-calibrations" class="opt-menu-item disabled">Save static calibrations</li>
              <li id="save-dynamic-calibrations" class="opt-menu-item disabled">Save dynamic calibrations</li>
              <li class="menu-delimiter"/>
              <li id="tools-img-converter" class="opt-menu-link" target="/tools/cimg.html">SD card image converter</li>
              <li id="tools-c-converter" class="opt-menu-link" target="/tools/csrc.html">Calibrations to C source</li>
              <li id="tools-bin-converter" class="opt-menu-link" target="/tools/cbin.html">Calibrations to Binary data</li>
              <li class="menu-delimiter"/>
              <li id="upload-xml" class="ask-opt-menu-item">Upload new XML file</li>
              <li class="menu-delimiter"/>
              <li id="reload-fw-api" class="ask-opt-menu-item">Upload new firmware API</li>
              <li id="drop-fw-api" class="ask-opt-menu-item disabled">Discard firmware API</li>
              <li class="menu-delimiter"/>
              <li id="clear-user-data" class="ask-opt-menu-item">Clear user settings</li>
              <li class="menu-delimiter"/>
              <li id="key-reference" class="opt-menu-item disabled">Keyboard reference</li>
              <li id="about-act" class="opt-menu-item">About ACT</li>
            </ul>
          </div>

        </header>

        <main class="main">

          <div class="tooltip hidden"/>

          <div class="left-pane">
            <div class="menu-top">
              <div class="menu-search-holder">
                <i class="foundicon-search"/>
                <input id="menu-search" spellcheck="false" type="text" class="search"/>
                <i id="clear-menu-search" class="foundicon-remove clear-search" tooltip="Clear search query"/>
              </div>
            </div>
            <nav class="navigation">
              <ul class="menu hw-fav-menu hidden"><li class="menu-delimiter hidden"/></ul>
              <ul class="menu hw-menu"><xsl:apply-templates select="device" mode="navigation"/></ul>
              <ul class="menu api-fav-menu hidden"><li class="menu-delimiter hidden"/></ul>
              <ul class="menu api-menu hidden"/>
              <ul class="menu static-fav-menu hidden"><li class="menu-delimiter hidden"/></ul>
              <ul class="menu static-menu hidden"/>
              <ul class="menu dynamic-fav-menu hidden"><li class="menu-delimiter hidden"/></ul>
              <ul class="menu dynamic-menu hidden"/>
              <ul class="menu file-fav-menu hidden"><li class="menu-delimiter hidden"/></ul>
              <ul class="menu file-menu hidden"/>
            </nav>
          </div>

          <div class="splitter"/>
          <div class="handle"><i class="foundicon-tri hide-arrow"/></div>

          <div class="content">

            <div class="container hw-controls">
              <div class="options-trigger">
                <label for="combine-multi-bytes">Combine multi-bytes</label>
                <input id="combine-multi-bytes" type="checkbox" checked="checked"/>
              </div>
              <xsl:apply-templates select="device" mode="device"/>
            </div>

            <div class="container api-controls hidden"/>
            <div class="container static-controls hidden"/>
            <div class="container dynamic-controls hidden"/>
            <div class="container file-controls hidden"/>

          </div>

        </main>

        <footer class="footer">
          <div class="footer-left">
            <p class="footer-label">Apical Control Tool</p>
            <p id="acs-ver" class="footer-sec"/>
          </div>
          <div class="footer-right">
            <progress id="progress" class="toolbar-progress hidden" value="0" max="100"/>
            <p id="error-count" class="footer-link hidden"/>
            <p id="srv-status" class="footer-status"/>
          </div>
        </footer>

        <div class="popup array-popup hidden">
          <div class="dialog">
            <div class="dialog-toolbar">
              <p class="popup-info"/>
              <i class="dialog-toolbar-btn dialog-close-btn foundicon-remove"/>
            </div>
            <div class="dialog-content"><textarea spellcheck="false" class="array-spread-sheet"/></div>
            <div class="dialog-btn-group">
              <button class="dialog-btn dialog-reload-btn">Reload</button>
              <button class="dialog-btn dialog-apply-btn">Apply</button>
              <button class="dialog-btn dialog-close-btn">Close</button>
            </div>
          </div>
        </div>

        <div class="popup ask-user-popup hidden">
          <div class="slim-dialog">
            <div class="dialog-content"><p class="dialog-message"/></div>
            <div class="dialog-btn-group">
              <button class="dialog-btn dialog-yes-btn">Yes</button>
              <button class="dialog-btn dialog-no-btn">No</button>
            </div>
          </div>
        </div>

        <div class="popup progress-popup hidden">
          <div class="slim-dialog">
            <div class="dialog-content">
              <p class="dialog-message"/>
              <progress id="modal-progress" class="flex-progress" value="0" max="100"/>
            </div>
          </div>
        </div>

        <div class="popup errors-popup hidden">
          <div class="slim-dialog">
            <div class="dialog-content">
              <ul class="error-list"/>
            </div>
            <div class="dialog-btn-group">
              <button class="dialog-btn dialog-close-btn">Close</button>
            </div>
          </div>
        </div>

        <div class="popup settings-popup hidden">
          <div class="dialog">
            <div class="dialog-toolbar">
              <i class="dialog-toolbar-btn dialog-close-btn foundicon-remove"/>
            </div>
            <div class="dialog-content">
              <div class="flex cfg-item"><label for="cfg-fancy-json">Human readable JSON output</label><input id="cfg-fancy-json" class="config" type="checkbox" cfg-type="boolean"/></div>
              <div class="flex cfg-item"><label for="cfg-polling-pace">Auto-polling pace (ms)</label><input id="cfg-polling-pace" class="config" type="text"  cfg-type="number" cfg-min="100" cfg-max="10000"/></div>
            </div>
            <div class="dialog-btn-group">
              <button class="dialog-btn dialog-close-btn">Close</button>
            </div>
          </div>
        </div>

        <div class="popup about-popup hidden">
          <div class="slim-dialog">
            <div class="dialog-toolbar">
              <i class="dialog-toolbar-btn dialog-close-btn foundicon-remove"/>
            </div>
            <div class="dialog-content"/>
            <div>
              <ul class="key-value-holder">
                <li class="key-value-item"><span class="kv-item-name">license</span><span class="kv-item-value"><a href="/license.html" target="_blank">click here</a></span></li>
              </ul>
            </div>
            <div class="dialog-btn-group">
              <button class="dialog-btn dialog-close-btn">Close</button>
            </div>
          </div>
        </div>

        <template id="fav-menu-item-template">
          <li class="section-link fav-menu-item">
            <p class="fav-menu-anchor"/>
            <i class="foundicon-star star-selected fav-menu-toggle"/>
          </li>
        </template>
        <template id="api-ctrl-template">
          <article class="control-item" type="api">
            <p class="bit-hint"/>
            <ul class="enum-holder"/>
            <div class="bit-switcher"/>
            <input type="checkbox" class="data-bit" />
            <input type="range" class="data-range" step="1" min="0" max="7" />
            <p class="radix-button" tooltip="Toggle hex / dec">0x</p>
            <input type="text" spellcheck="false" class="val-text" />
            <i class="reload-button foundicon-refresh" tooltip="Reload parameter"/>
            <i class="star-button foundicon-star" tooltip="Add to favourites"/>
            <label class="cmd-label"/>
          </article>
        </template>
        <template id="api-enum-template">
          <li class="radio-item">
            <label class="radio-label"><input type="radio" class="radio-button"/><span/></label>
          </li>
        </template>
        <template id="api-menu-item-template">
          <li class="section-link"/>
        </template>
        <template id="api-section-template">
          <section class="section hidden">
            <header>
              <h3 class="s-header"></h3>
              <div class="page-sub-menu">
                <i class="like-page foundicon-star" tooltip="Mark page as favourite"/>
                <i class="navigate-back foundicon-back"/>
                <i class="navigate-forward foundicon-forward"/>
              </div>
            </header>
          </section>
        </template>
        <template id="calibration-ctrl-template">
          <article class="control-item" type="calibration">
            <div class="hint-holder">
              <p class="bit-hint"/>
              <p class="mxn-hint"/>
            </div>
            <ul class="array-table"/>
            <p class="radix-button" tooltip="Toggle hex / dec">0x</p>
            <i class="edit-array-button foundicon-edit" tooltip="Edit data"/>
            <i class="reload-button foundicon-refresh" tooltip="Reload value"/>
            <i class="star-button foundicon-star" tooltip="Add to favourites"/>
            <label class="cmd-label"/>
          </article>
        </template>
        <template id="file-transfer-ctrl-template">
          <article class="control-item" type="file">
            <input type="file" class="file-transfer-loader hidden"/>
            <i class="upload-file-button foundicon-upload" tooltip="Upload binary file"/>
            <i class="download-file-button foundicon-download" tooltip="Download as binary file"/>
            <i class="star-button foundicon-star" tooltip="Add to favourites"/>
            <label class="cmd-label"/>
          </article>
        </template>
        <template id="array-cell-template">
          <li class="array-cell" spellcheck="false"/>
        </template>
        <template id="error-list-item-template">
          <li class="error-line"><span class="error-timestamp"/><span class="error-message-content"/></li>
        </template>
        <template id="key-value-holder-template">
          <ul class="key-value-holder"/>
        </template>
        <template id="key-value-item-template">
          <li class="key-value-item"><span class="kv-item-name"/><span class="kv-item-value"/></li>
        </template>

        <script src="js/acs.min.js"/>

      </body>
    </html>
  </xsl:template>

  <xsl:template match="device" mode="navigation">
    <li>
      <xsl:attribute name="class">section-link</xsl:attribute>
      <xsl:attribute name="title"><xsl:value-of select="@name"/></xsl:attribute>
      <xsl:attribute name="section"><xsl:value-of select="@name"/></xsl:attribute>
      <xsl:attribute name="type">hw</xsl:attribute>
      <xsl:attribute name="search">
        <xsl:value-of select="translate(@name, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
      </xsl:attribute>
      <xsl:value-of select="@name"/>
    </li>
  </xsl:template>

  <xsl:template match="device" mode="device">
    <section>
      <xsl:attribute name="class">section hidden</xsl:attribute>
      <xsl:attribute name="type">hw</xsl:attribute>
      <xsl:attribute name="section">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
      <xsl:attribute name="id">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
      <header>
        <h3 class="s-header"><xsl:value-of select="@name"/></h3>
        <div class="page-sub-menu">
          <i class="like-page foundicon-star" tooltip="Mark page as favourite"/>
          <i class="navigate-back foundicon-back"/>
          <i class="navigate-forward foundicon-forward"/>
        </div>
      </header>
      <xsl:apply-templates mode="controller"/>
    </section>
  </xsl:template>

  <xsl:template match="text" mode="controller"/>

  <xsl:template match="byte[not(starts-with(@addr,'%'))]|bit|lut|array" mode="controller">
    <xsl:variable name="UID"><xsl:value-of select="translate(concat(concat(../@name, '-'), @name),'_ /()','---')"/></xsl:variable>
    <xsl:variable name="uid"><xsl:value-of select="translate($UID, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/></xsl:variable>
    <xsl:variable name="data-type"><xsl:value-of select="name(.)"/></xsl:variable>
    <xsl:variable name="command"><xsl:value-of select="../@name" />/<xsl:value-of select="@name" /></xsl:variable>
    <article class="control-item" type="hw">
      <xsl:attribute name="command"><xsl:value-of select="$command"/></xsl:attribute>
      <xsl:attribute name="data-address"><xsl:value-of select="@addr"/></xsl:attribute>
      <xsl:attribute name="data-mode"><xsl:value-of select="@mode"/></xsl:attribute>
      <xsl:attribute name="data-type"><xsl:value-of select="$data-type"/></xsl:attribute>
      <xsl:attribute name="display-text"><xsl:value-of select="$command"/></xsl:attribute>
      <xsl:if test="@nodes">
        <xsl:attribute name="data-nodes"><xsl:value-of select="@nodes"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="@num_nodes">
        <xsl:attribute name="data-nodes"><xsl:value-of select="@num_nodes"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="@table_bits">
        <xsl:attribute name="table-bits"><xsl:value-of select="@table_bits"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="@table_variant">
        <xsl:attribute name="table-align"><xsl:value-of select="@table_variant"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="@arrangement">
        <xsl:attribute name="arrangement"><xsl:value-of select="@arrangement"/></xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="." mode="type-controller">
        <xsl:with-param name="uid"><xsl:value-of select="$uid"/></xsl:with-param>
      </xsl:apply-templates>
      <i class="reload-button foundicon-refresh" tooltip="Reload parameter"/>
      <i class="star-button foundicon-star" tooltip="Add to favourites"/>
      <p class="cmd-label">
        <label class="cmd-show">
          <xsl:attribute name="for"><xsl:value-of select="$uid"/></xsl:attribute>
          <xsl:choose>
            <xsl:when test="@tooltip"><xsl:attribute name="tooltip"><xsl:value-of select="@tooltip"/></xsl:attribute></xsl:when>
            <xsl:otherwise></xsl:otherwise>
          </xsl:choose>
          <xsl:value-of select="@name"/>
        </label>
        <span class="byte-hint"/>
      </p>
    </article>
  </xsl:template>

  <xsl:template match="byte" mode="type-controller">
    <xsl:param name="uid"/>
    <p class="bit-hint"/>
    <input type="range" class="data-range">
      <xsl:attribute name="min">0</xsl:attribute>
      <xsl:attribute name="max">7</xsl:attribute>
      <xsl:attribute name="step">1</xsl:attribute>
      <xsl:if test="@mode='RO'">
        <xsl:attribute name="readonly"/>
        <xsl:attribute name="disabled"/>
      </xsl:if>
      <xsl:attribute name="data-default">
        <xsl:value-of select="@default"/>
      </xsl:attribute>
    </input>
    <p class="radix-button" tooltip="Toggle hex / dec representation">0x</p>
    <input type="text" spellcheck="false" class="val-text">
      <xsl:attribute name="id"><xsl:value-of select="$uid"/></xsl:attribute>
      <xsl:if test="@mode='RO'">
        <xsl:attribute name="readonly"/>
      </xsl:if>
    </input>
  </xsl:template>

  <xsl:template match="bit" mode="type-controller">
    <xsl:param name="uid"/>
    <xsl:call-template name="gen-check-box">
      <xsl:with-param name="id"><xsl:value-of select="$uid"/></xsl:with-param>
      <xsl:with-param name="disabled" select="boolean(@mode='RO')"/>
      <xsl:with-param name="default" select="@default"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="lut|array" mode="type-controller">
    <div class="hint-holder">
      <p class="bit-hint"/>
      <p class="mxn-hint"><xsl:value-of select="@arrangement"/></p>
    </div>
    <ul class="array-table"></ul>
    <p class="radix-button" tooltip="Toggle HEX / DEC">0x</p>
    <i class="edit-array-button foundicon-edit" tooltip="Edit data"/>
  </xsl:template>

  <xsl:template name="gen-check-box">
    <xsl:param name="id"/>
    <xsl:param name="disabled"/>
    <xsl:param name="default" select="0"/>
    <div class="bit-switcher"/>
    <input type="checkbox" class="data-bit">
      <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
      <xsl:if test="$disabled"><xsl:attribute name="disabled"/></xsl:if>
      <xsl:attribute name="data-default"><xsl:value-of select="$default"/></xsl:attribute>
    </input>
  </xsl:template>

</xsl:stylesheet>
