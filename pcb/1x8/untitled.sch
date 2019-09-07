<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="9.4.2">
<drawing>
<settings>
<setting alwaysvectorfont="no"/>
<setting verticaltext="up"/>
</settings>
<grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.01" altunitdist="inch" altunit="inch"/>
<layers>
<layer number="1" name="Top" color="4" fill="1" visible="no" active="no"/>
<layer number="16" name="Bottom" color="1" fill="1" visible="no" active="no"/>
<layer number="17" name="Pads" color="2" fill="1" visible="no" active="no"/>
<layer number="18" name="Vias" color="2" fill="1" visible="no" active="no"/>
<layer number="19" name="Unrouted" color="6" fill="1" visible="no" active="no"/>
<layer number="20" name="Dimension" color="15" fill="1" visible="no" active="no"/>
<layer number="21" name="tPlace" color="16" fill="1" visible="no" active="no"/>
<layer number="22" name="bPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="23" name="tOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="24" name="bOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="25" name="tNames" color="7" fill="1" visible="no" active="no"/>
<layer number="26" name="bNames" color="7" fill="1" visible="no" active="no"/>
<layer number="27" name="tValues" color="7" fill="1" visible="no" active="no"/>
<layer number="28" name="bValues" color="7" fill="1" visible="no" active="no"/>
<layer number="29" name="tStop" color="7" fill="3" visible="no" active="no"/>
<layer number="30" name="bStop" color="7" fill="6" visible="no" active="no"/>
<layer number="31" name="tCream" color="7" fill="4" visible="no" active="no"/>
<layer number="32" name="bCream" color="7" fill="5" visible="no" active="no"/>
<layer number="33" name="tFinish" color="6" fill="3" visible="no" active="no"/>
<layer number="34" name="bFinish" color="6" fill="6" visible="no" active="no"/>
<layer number="35" name="tGlue" color="7" fill="4" visible="no" active="no"/>
<layer number="36" name="bGlue" color="7" fill="5" visible="no" active="no"/>
<layer number="37" name="tTest" color="7" fill="1" visible="no" active="no"/>
<layer number="38" name="bTest" color="7" fill="1" visible="no" active="no"/>
<layer number="39" name="tKeepout" color="4" fill="11" visible="no" active="no"/>
<layer number="40" name="bKeepout" color="1" fill="11" visible="no" active="no"/>
<layer number="41" name="tRestrict" color="4" fill="10" visible="no" active="no"/>
<layer number="42" name="bRestrict" color="1" fill="10" visible="no" active="no"/>
<layer number="43" name="vRestrict" color="2" fill="10" visible="no" active="no"/>
<layer number="44" name="Drills" color="7" fill="1" visible="no" active="no"/>
<layer number="45" name="Holes" color="7" fill="1" visible="no" active="no"/>
<layer number="46" name="Milling" color="3" fill="1" visible="no" active="no"/>
<layer number="47" name="Measures" color="7" fill="1" visible="no" active="no"/>
<layer number="48" name="Document" color="7" fill="1" visible="no" active="no"/>
<layer number="49" name="Reference" color="7" fill="1" visible="no" active="no"/>
<layer number="50" name="dxf" color="7" fill="1" visible="no" active="no"/>
<layer number="51" name="tDocu" color="14" fill="1" visible="no" active="no"/>
<layer number="52" name="bDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="53" name="tGND_GNDA" color="7" fill="9" visible="no" active="no"/>
<layer number="54" name="bGND_GNDA" color="1" fill="9" visible="no" active="no"/>
<layer number="56" name="wert" color="7" fill="1" visible="no" active="no"/>
<layer number="57" name="tCAD" color="7" fill="1" visible="no" active="no"/>
<layer number="59" name="tCarbon" color="7" fill="1" visible="no" active="no"/>
<layer number="60" name="bCarbon" color="7" fill="1" visible="no" active="no"/>
<layer number="88" name="SimResults" color="9" fill="1" visible="yes" active="yes"/>
<layer number="89" name="SimProbes" color="9" fill="1" visible="yes" active="yes"/>
<layer number="90" name="Modules" color="5" fill="1" visible="yes" active="yes"/>
<layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes"/>
<layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes"/>
<layer number="93" name="Pins" color="2" fill="1" visible="no" active="yes"/>
<layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes"/>
<layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes"/>
<layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes"/>
<layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes"/>
<layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes"/>
<layer number="99" name="SpiceOrder" color="7" fill="1" visible="yes" active="yes"/>
<layer number="100" name="Muster" color="7" fill="1" visible="no" active="no"/>
<layer number="101" name="Patch_Top" color="12" fill="4" visible="yes" active="yes"/>
<layer number="102" name="Vscore" color="7" fill="1" visible="yes" active="yes"/>
<layer number="103" name="tMap" color="7" fill="1" visible="yes" active="yes"/>
<layer number="104" name="Name" color="16" fill="1" visible="yes" active="yes"/>
<layer number="105" name="tPlate" color="7" fill="1" visible="yes" active="yes"/>
<layer number="106" name="bPlate" color="7" fill="1" visible="yes" active="yes"/>
<layer number="107" name="Crop" color="7" fill="1" visible="yes" active="yes"/>
<layer number="108" name="tplace-old" color="10" fill="1" visible="yes" active="yes"/>
<layer number="109" name="ref-old" color="11" fill="1" visible="yes" active="yes"/>
<layer number="110" name="fp0" color="7" fill="1" visible="yes" active="yes"/>
<layer number="111" name="LPC17xx" color="7" fill="1" visible="yes" active="yes"/>
<layer number="112" name="tSilk" color="7" fill="1" visible="yes" active="yes"/>
<layer number="113" name="IDFDebug" color="4" fill="1" visible="yes" active="yes"/>
<layer number="114" name="Badge_Outline" color="7" fill="1" visible="yes" active="yes"/>
<layer number="115" name="ReferenceISLANDS" color="7" fill="1" visible="yes" active="yes"/>
<layer number="116" name="Patch_BOT" color="9" fill="4" visible="yes" active="yes"/>
<layer number="118" name="Rect_Pads" color="7" fill="1" visible="yes" active="yes"/>
<layer number="121" name="_tsilk" color="7" fill="1" visible="yes" active="yes"/>
<layer number="122" name="_bsilk" color="7" fill="1" visible="yes" active="yes"/>
<layer number="123" name="tTestmark" color="7" fill="1" visible="yes" active="yes"/>
<layer number="124" name="bTestmark" color="7" fill="1" visible="yes" active="yes"/>
<layer number="125" name="_tNames" color="7" fill="1" visible="yes" active="yes"/>
<layer number="126" name="_bNames" color="7" fill="1" visible="yes" active="yes"/>
<layer number="127" name="_tValues" color="7" fill="1" visible="yes" active="yes"/>
<layer number="128" name="_bValues" color="7" fill="1" visible="yes" active="yes"/>
<layer number="129" name="Mask" color="7" fill="1" visible="yes" active="yes"/>
<layer number="131" name="tAdjust" color="7" fill="1" visible="yes" active="yes"/>
<layer number="132" name="bAdjust" color="7" fill="1" visible="yes" active="yes"/>
<layer number="144" name="Drill_legend" color="7" fill="1" visible="yes" active="yes"/>
<layer number="150" name="Notes" color="7" fill="1" visible="yes" active="yes"/>
<layer number="151" name="HeatSink" color="7" fill="1" visible="yes" active="yes"/>
<layer number="152" name="_bDocu" color="7" fill="1" visible="yes" active="yes"/>
<layer number="153" name="FabDoc1" color="7" fill="1" visible="yes" active="yes"/>
<layer number="154" name="FabDoc2" color="7" fill="1" visible="yes" active="yes"/>
<layer number="155" name="FabDoc3" color="7" fill="1" visible="yes" active="yes"/>
<layer number="199" name="Contour" color="7" fill="1" visible="yes" active="yes"/>
<layer number="200" name="200bmp" color="1" fill="10" visible="yes" active="yes"/>
<layer number="201" name="201bmp" color="2" fill="10" visible="yes" active="yes"/>
<layer number="202" name="202bmp" color="3" fill="10" visible="yes" active="yes"/>
<layer number="203" name="203bmp" color="4" fill="10" visible="yes" active="yes"/>
<layer number="204" name="204bmp" color="5" fill="10" visible="yes" active="yes"/>
<layer number="205" name="205bmp" color="6" fill="10" visible="yes" active="yes"/>
<layer number="206" name="206bmp" color="7" fill="10" visible="yes" active="yes"/>
<layer number="207" name="207bmp" color="8" fill="10" visible="yes" active="yes"/>
<layer number="208" name="208bmp" color="9" fill="10" visible="yes" active="yes"/>
<layer number="209" name="209bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="210" name="210bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="211" name="211bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="212" name="212bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="213" name="213bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="214" name="214bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="215" name="215bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="216" name="216bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="217" name="217bmp" color="18" fill="1" visible="no" active="no"/>
<layer number="218" name="218bmp" color="19" fill="1" visible="no" active="no"/>
<layer number="219" name="219bmp" color="20" fill="1" visible="no" active="no"/>
<layer number="220" name="220bmp" color="21" fill="1" visible="no" active="no"/>
<layer number="221" name="221bmp" color="22" fill="1" visible="no" active="no"/>
<layer number="222" name="222bmp" color="23" fill="1" visible="no" active="no"/>
<layer number="223" name="223bmp" color="24" fill="1" visible="no" active="no"/>
<layer number="224" name="224bmp" color="25" fill="1" visible="no" active="no"/>
<layer number="225" name="225bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="226" name="226bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="227" name="227bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="228" name="228bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="229" name="229bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="230" name="230bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="231" name="231bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="232" name="Eagle3D_PG2" color="7" fill="1" visible="yes" active="yes"/>
<layer number="233" name="Eagle3D_PG3" color="7" fill="1" visible="yes" active="yes"/>
<layer number="248" name="Housing" color="7" fill="1" visible="yes" active="yes"/>
<layer number="249" name="Edge" color="7" fill="1" visible="yes" active="yes"/>
<layer number="250" name="Descript" color="3" fill="1" visible="no" active="no"/>
<layer number="251" name="SMDround" color="12" fill="11" visible="no" active="no"/>
<layer number="254" name="cooling" color="7" fill="1" visible="yes" active="yes"/>
<layer number="255" name="routoute" color="7" fill="1" visible="yes" active="yes"/>
</layers>
<schematic xreflabel="%F%N/%S.%C%R" xrefpart="/%S.%C%R">
<libraries>
<library name="wirepad" urn="urn:adsk.eagle:library:412">
<description>&lt;b&gt;Single Pads&lt;/b&gt;&lt;p&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
<package name="SMD1,27-2,54" urn="urn:adsk.eagle:footprint:30822/1" library_version="1">
<description>&lt;b&gt;SMD PAD&lt;/b&gt;</description>
<smd name="1" x="0" y="0" dx="1.27" dy="2.54" layer="1"/>
<text x="0" y="0" size="0.0254" layer="27">&gt;VALUE</text>
<text x="-0.8" y="-2.4" size="1.27" layer="25" rot="R90">&gt;NAME</text>
</package>
</packages>
<packages3d>
<package3d name="SMD1,27-2,54" urn="urn:adsk.eagle:package:30839/1" type="box" library_version="1">
<description>SMD PAD</description>
<packageinstances>
<packageinstance name="SMD1,27-2,54"/>
</packageinstances>
</package3d>
</packages3d>
<symbols>
<symbol name="PAD" urn="urn:adsk.eagle:symbol:30808/1" library_version="1">
<wire x1="-1.016" y1="1.016" x2="1.016" y2="-1.016" width="0.254" layer="94"/>
<wire x1="-1.016" y1="-1.016" x2="1.016" y2="1.016" width="0.254" layer="94"/>
<text x="-1.143" y="1.8542" size="1.778" layer="95">&gt;NAME</text>
<text x="-1.143" y="-3.302" size="1.778" layer="96">&gt;VALUE</text>
<pin name="P" x="2.54" y="0" visible="off" length="short" direction="pas" rot="R180"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="SMD2" urn="urn:adsk.eagle:component:30857/1" prefix="PAD" uservalue="yes" library_version="1">
<description>&lt;b&gt;SMD PAD&lt;/b&gt;</description>
<gates>
<gate name="1" symbol="PAD" x="0" y="0"/>
</gates>
<devices>
<device name="" package="SMD1,27-2,54">
<connects>
<connect gate="1" pin="P" pad="1"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:30839/1"/>
</package3dinstances>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="BPW_34_S-Z">
<packages>
<package name="DIO_BPW_34_S-Z">
<rectangle x1="-3.8" y1="-0.65" x2="-2.3" y2="0.65" layer="29"/>
<rectangle x1="2.3" y1="-1.05" x2="3.8" y2="1.05" layer="29"/>
<rectangle x1="2.4" y1="-0.95" x2="3.7" y2="0.95" layer="31"/>
<rectangle x1="-3.7" y1="-0.55" x2="-2.4" y2="0.55" layer="31"/>
<wire x1="-2.2" y1="-1.925" x2="-2.2" y2="1.925" width="0.127" layer="51"/>
<wire x1="-2.2" y1="1.925" x2="2.2" y2="1.925" width="0.127" layer="51"/>
<wire x1="2.2" y1="1.925" x2="2.2" y2="-1.925" width="0.127" layer="51"/>
<wire x1="2.2" y1="-1.925" x2="-2.2" y2="-1.925" width="0.127" layer="51"/>
<wire x1="-2.2" y1="0.91" x2="-2.2" y2="1.925" width="0.127" layer="21"/>
<wire x1="-2.2" y1="1.925" x2="2.2" y2="1.925" width="0.127" layer="21"/>
<wire x1="2.2" y1="1.925" x2="2.2" y2="1.21" width="0.127" layer="21"/>
<wire x1="-2.2" y1="-0.91" x2="-2.2" y2="-1.925" width="0.127" layer="21"/>
<wire x1="-2.2" y1="-1.925" x2="2.2" y2="-1.925" width="0.127" layer="21"/>
<wire x1="2.2" y1="-1.925" x2="2.2" y2="-1.31" width="0.127" layer="21"/>
<wire x1="-4.05" y1="-2.175" x2="-4.05" y2="2.175" width="0.05" layer="39"/>
<wire x1="-4.05" y1="2.175" x2="4.05" y2="2.175" width="0.05" layer="39"/>
<wire x1="4.05" y1="2.175" x2="4.05" y2="-2.175" width="0.05" layer="39"/>
<wire x1="4.05" y1="-2.175" x2="-4.05" y2="-2.175" width="0.05" layer="39"/>
<text x="-4.1" y="2.3" size="0.8128" layer="25">&gt;NAME</text>
<text x="-4.1" y="-3.1" size="0.8128" layer="27">&gt;VALUE</text>
<circle x="4.4" y="0" radius="0.1" width="0.2" layer="21"/>
<circle x="4.4" y="0" radius="0.1" width="0.2" layer="51"/>
<smd name="A" x="-3.05" y="0" dx="1.2" dy="1.4" layer="1" rot="R90" stop="no" cream="no"/>
<smd name="C" x="3.05" y="0" dx="2" dy="1.4" layer="1" rot="R90" stop="no" cream="no"/>
</package>
</packages>
<symbols>
<symbol name="BPW_34_S-Z">
<wire x1="-2.54" y1="1.524" x2="-2.54" y2="0" width="0.254" layer="94"/>
<wire x1="-2.54" y1="0" x2="-2.54" y2="-1.524" width="0.254" layer="94"/>
<wire x1="-2.54" y1="-1.524" x2="0" y2="0" width="0.254" layer="94"/>
<wire x1="0" y1="0" x2="-2.54" y2="1.524" width="0.254" layer="94"/>
<wire x1="0" y1="1.524" x2="0" y2="-1.524" width="0.254" layer="94"/>
<wire x1="-2.54" y1="0" x2="-5.08" y2="0" width="0.1524" layer="94"/>
<wire x1="-1.778" y1="2.032" x2="0" y2="4.064" width="0.254" layer="94"/>
<text x="-3.0988" y="4.4958" size="1.27" layer="95">&gt;NAME</text>
<text x="-3.556" y="-3.302" size="1.27" layer="96">&gt;VALUE</text>
<wire x1="-1.4478" y1="2.9972" x2="-0.889" y2="2.5146" width="0.254" layer="94"/>
<wire x1="-0.889" y1="2.5146" x2="-1.778" y2="2.032" width="0.254" layer="94"/>
<wire x1="-1.778" y1="2.032" x2="-1.4478" y2="2.9972" width="0.254" layer="94"/>
<wire x1="-1.4478" y1="2.9972" x2="-1.4732" y2="2.2606" width="0.254" layer="94"/>
<wire x1="-1.4732" y1="2.2606" x2="-1.3462" y2="2.2606" width="0.254" layer="94"/>
<wire x1="-1.0668" y1="2.5908" x2="-1.2954" y2="2.4384" width="0.254" layer="94"/>
<wire x1="-0.5334" y1="1.9304" x2="1.2446" y2="3.9624" width="0.254" layer="94"/>
<wire x1="-0.2032" y1="2.8956" x2="0.3556" y2="2.413" width="0.254" layer="94"/>
<wire x1="0.3556" y1="2.413" x2="-0.5334" y2="1.9304" width="0.254" layer="94"/>
<wire x1="-0.5334" y1="1.9304" x2="-0.2032" y2="2.8956" width="0.254" layer="94"/>
<wire x1="-0.2032" y1="2.8956" x2="-0.2286" y2="2.159" width="0.254" layer="94"/>
<wire x1="-0.2286" y1="2.159" x2="-0.1016" y2="2.159" width="0.254" layer="94"/>
<wire x1="0.1778" y1="2.4892" x2="-0.0508" y2="2.3368" width="0.254" layer="94"/>
<pin name="C" x="5.08" y="0" visible="pad" length="middle" direction="pas" rot="R180"/>
<pin name="A" x="-7.62" y="0" visible="pad" length="short" direction="pas"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="BPW_34_S-Z" prefix="D">
<description>Silicon PIN Photodiode</description>
<gates>
<gate name="G$1" symbol="BPW_34_S-Z" x="0" y="0"/>
</gates>
<devices>
<device name="" package="DIO_BPW_34_S-Z">
<connects>
<connect gate="G$1" pin="A" pad="A"/>
<connect gate="G$1" pin="C" pad="C"/>
</connects>
<technologies>
<technology name="">
<attribute name="DESCRIPTION" value=" Photodiode PIN Chip 850nm 0.62A/W Sensitivity 2-Pin DIL SMT "/>
<attribute name="DIGI-KEY_PART_NUMBER" value="475-2659-1-ND"/>
<attribute name="DIGI-KEY_PURCHASE_URL" value="https://www.digikey.com/product-detail/en/osram-opto-semiconductors-inc/BPW-34-S-Z/475-2659-1-ND/1893861?utm_source=snapeda&amp;utm_medium=aggregator&amp;utm_campaign=symbol"/>
<attribute name="MF" value="OSRAM Opto"/>
<attribute name="MP" value="BPW 34 S-Z"/>
<attribute name="PACKAGE" value="SMD-2 OSRAM Opto"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
</libraries>
<attributes>
</attributes>
<variantdefs>
</variantdefs>
<classes>
<class number="0" name="default" width="0" drill="0">
</class>
</classes>
<parts>
<part name="PAD9" library="wirepad" library_urn="urn:adsk.eagle:library:412" deviceset="SMD2" device="" package3d_urn="urn:adsk.eagle:package:30839/1"/>
<part name="D1" library="BPW_34_S-Z" deviceset="BPW_34_S-Z" device=""/>
<part name="D2" library="BPW_34_S-Z" deviceset="BPW_34_S-Z" device=""/>
<part name="D3" library="BPW_34_S-Z" deviceset="BPW_34_S-Z" device=""/>
<part name="D4" library="BPW_34_S-Z" deviceset="BPW_34_S-Z" device=""/>
<part name="D5" library="BPW_34_S-Z" deviceset="BPW_34_S-Z" device=""/>
<part name="D6" library="BPW_34_S-Z" deviceset="BPW_34_S-Z" device=""/>
<part name="D7" library="BPW_34_S-Z" deviceset="BPW_34_S-Z" device=""/>
<part name="D8" library="BPW_34_S-Z" deviceset="BPW_34_S-Z" device=""/>
<part name="PAD1" library="wirepad" library_urn="urn:adsk.eagle:library:412" deviceset="SMD2" device="" package3d_urn="urn:adsk.eagle:package:30839/1"/>
<part name="PAD2" library="wirepad" library_urn="urn:adsk.eagle:library:412" deviceset="SMD2" device="" package3d_urn="urn:adsk.eagle:package:30839/1"/>
<part name="PAD3" library="wirepad" library_urn="urn:adsk.eagle:library:412" deviceset="SMD2" device="" package3d_urn="urn:adsk.eagle:package:30839/1"/>
<part name="PAD4" library="wirepad" library_urn="urn:adsk.eagle:library:412" deviceset="SMD2" device="" package3d_urn="urn:adsk.eagle:package:30839/1"/>
<part name="PAD5" library="wirepad" library_urn="urn:adsk.eagle:library:412" deviceset="SMD2" device="" package3d_urn="urn:adsk.eagle:package:30839/1"/>
<part name="PAD6" library="wirepad" library_urn="urn:adsk.eagle:library:412" deviceset="SMD2" device="" package3d_urn="urn:adsk.eagle:package:30839/1"/>
<part name="PAD7" library="wirepad" library_urn="urn:adsk.eagle:library:412" deviceset="SMD2" device="" package3d_urn="urn:adsk.eagle:package:30839/1"/>
<part name="PAD8" library="wirepad" library_urn="urn:adsk.eagle:library:412" deviceset="SMD2" device="" package3d_urn="urn:adsk.eagle:package:30839/1"/>
</parts>
<sheets>
<sheet>
<plain>
</plain>
<instances>
<instance part="PAD9" gate="1" x="7.62" y="27.94" smashed="yes">
<attribute name="NAME" x="6.477" y="29.7942" size="1.778" layer="95"/>
<attribute name="VALUE" x="6.477" y="24.638" size="1.778" layer="96"/>
</instance>
<instance part="D1" gate="G$1" x="30.48" y="27.94" smashed="yes" rot="MR0">
<attribute name="NAME" x="36.1188" y="29.8958" size="1.27" layer="95" rot="MR0"/>
<attribute name="VALUE" x="41.656" y="22.098" size="1.27" layer="96" rot="MR0"/>
</instance>
<instance part="D2" gate="G$1" x="30.48" y="15.24" smashed="yes" rot="MR0">
<attribute name="NAME" x="36.1188" y="17.1958" size="1.27" layer="95" rot="MR0"/>
<attribute name="VALUE" x="41.656" y="9.398" size="1.27" layer="96" rot="MR0"/>
</instance>
<instance part="D3" gate="G$1" x="30.48" y="2.54" smashed="yes" rot="MR0">
<attribute name="NAME" x="36.1188" y="4.4958" size="1.27" layer="95" rot="MR0"/>
<attribute name="VALUE" x="41.656" y="-3.302" size="1.27" layer="96" rot="MR0"/>
</instance>
<instance part="D4" gate="G$1" x="30.48" y="-10.16" smashed="yes" rot="MR0">
<attribute name="NAME" x="36.1188" y="-8.2042" size="1.27" layer="95" rot="MR0"/>
<attribute name="VALUE" x="41.656" y="-16.002" size="1.27" layer="96" rot="MR0"/>
</instance>
<instance part="D5" gate="G$1" x="63.5" y="27.94" smashed="yes" rot="MR0">
<attribute name="NAME" x="69.1388" y="29.8958" size="1.27" layer="95" rot="MR0"/>
<attribute name="VALUE" x="74.676" y="22.098" size="1.27" layer="96" rot="MR0"/>
</instance>
<instance part="D6" gate="G$1" x="63.5" y="15.24" smashed="yes" rot="MR0">
<attribute name="NAME" x="69.1388" y="17.1958" size="1.27" layer="95" rot="MR0"/>
<attribute name="VALUE" x="74.676" y="9.398" size="1.27" layer="96" rot="MR0"/>
</instance>
<instance part="D7" gate="G$1" x="63.5" y="2.54" smashed="yes" rot="MR0">
<attribute name="NAME" x="69.1388" y="4.4958" size="1.27" layer="95" rot="MR0"/>
<attribute name="VALUE" x="74.676" y="-3.302" size="1.27" layer="96" rot="MR0"/>
</instance>
<instance part="D8" gate="G$1" x="63.5" y="-10.16" smashed="yes" rot="MR0">
<attribute name="NAME" x="69.1388" y="-8.2042" size="1.27" layer="95" rot="MR0"/>
<attribute name="VALUE" x="74.676" y="-16.002" size="1.27" layer="96" rot="MR0"/>
</instance>
<instance part="PAD1" gate="1" x="45.72" y="27.94" smashed="yes" rot="R180">
<attribute name="NAME" x="46.863" y="26.0858" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="46.863" y="31.242" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="PAD2" gate="1" x="45.72" y="15.24" smashed="yes" rot="R180">
<attribute name="NAME" x="46.863" y="13.3858" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="46.863" y="18.542" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="PAD3" gate="1" x="45.72" y="2.54" smashed="yes" rot="R180">
<attribute name="NAME" x="46.863" y="0.6858" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="46.863" y="5.842" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="PAD4" gate="1" x="45.72" y="-10.16" smashed="yes" rot="R180">
<attribute name="NAME" x="46.863" y="-12.0142" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="46.863" y="-6.858" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="PAD5" gate="1" x="78.74" y="27.94" smashed="yes" rot="R180">
<attribute name="NAME" x="79.883" y="26.0858" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="79.883" y="31.242" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="PAD6" gate="1" x="78.74" y="15.24" smashed="yes" rot="R180">
<attribute name="NAME" x="79.883" y="13.3858" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="79.883" y="18.542" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="PAD7" gate="1" x="78.74" y="2.54" smashed="yes" rot="R180">
<attribute name="NAME" x="79.883" y="0.6858" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="79.883" y="5.842" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="PAD8" gate="1" x="78.74" y="-10.16" smashed="yes" rot="R180">
<attribute name="NAME" x="79.883" y="-12.0142" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="79.883" y="-6.858" size="1.778" layer="96" rot="R180"/>
</instance>
</instances>
<busses>
</busses>
<nets>
<net name="N$9" class="0">
<segment>
<pinref part="D1" gate="G$1" pin="A"/>
<wire x1="38.1" y1="27.94" x2="43.18" y2="27.94" width="0.1524" layer="91"/>
<pinref part="PAD1" gate="1" pin="P"/>
</segment>
</net>
<net name="N$10" class="0">
<segment>
<pinref part="D2" gate="G$1" pin="A"/>
<wire x1="38.1" y1="15.24" x2="43.18" y2="15.24" width="0.1524" layer="91"/>
<pinref part="PAD2" gate="1" pin="P"/>
</segment>
</net>
<net name="N$11" class="0">
<segment>
<pinref part="D3" gate="G$1" pin="A"/>
<wire x1="38.1" y1="2.54" x2="43.18" y2="2.54" width="0.1524" layer="91"/>
<pinref part="PAD3" gate="1" pin="P"/>
</segment>
</net>
<net name="N$12" class="0">
<segment>
<pinref part="D4" gate="G$1" pin="A"/>
<wire x1="38.1" y1="-10.16" x2="43.18" y2="-10.16" width="0.1524" layer="91"/>
<pinref part="PAD4" gate="1" pin="P"/>
</segment>
</net>
<net name="N$13" class="0">
<segment>
<pinref part="D5" gate="G$1" pin="A"/>
<wire x1="71.12" y1="27.94" x2="76.2" y2="27.94" width="0.1524" layer="91"/>
<pinref part="PAD5" gate="1" pin="P"/>
</segment>
</net>
<net name="N$14" class="0">
<segment>
<pinref part="D6" gate="G$1" pin="A"/>
<wire x1="71.12" y1="15.24" x2="76.2" y2="15.24" width="0.1524" layer="91"/>
<pinref part="PAD6" gate="1" pin="P"/>
</segment>
</net>
<net name="N$15" class="0">
<segment>
<pinref part="D7" gate="G$1" pin="A"/>
<wire x1="71.12" y1="2.54" x2="76.2" y2="2.54" width="0.1524" layer="91"/>
<pinref part="PAD7" gate="1" pin="P"/>
</segment>
</net>
<net name="N$16" class="0">
<segment>
<pinref part="D8" gate="G$1" pin="A"/>
<wire x1="71.12" y1="-10.16" x2="76.2" y2="-10.16" width="0.1524" layer="91"/>
<pinref part="PAD8" gate="1" pin="P"/>
</segment>
</net>
<net name="VCC" class="0">
<segment>
<pinref part="PAD9" gate="1" pin="P"/>
<wire x1="10.16" y1="27.94" x2="17.78" y2="27.94" width="0.1524" layer="91"/>
<label x="12.7" y="27.94" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="D1" gate="G$1" pin="C"/>
<wire x1="25.4" y1="27.94" x2="20.32" y2="27.94" width="0.1524" layer="91"/>
<label x="20.32" y="27.94" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="D2" gate="G$1" pin="C"/>
<wire x1="25.4" y1="15.24" x2="20.32" y2="15.24" width="0.1524" layer="91"/>
<label x="20.32" y="15.24" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="D3" gate="G$1" pin="C"/>
<wire x1="25.4" y1="2.54" x2="20.32" y2="2.54" width="0.1524" layer="91"/>
<label x="20.32" y="2.54" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="D4" gate="G$1" pin="C"/>
<wire x1="25.4" y1="-10.16" x2="20.32" y2="-10.16" width="0.1524" layer="91"/>
<label x="20.32" y="-10.16" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="D5" gate="G$1" pin="C"/>
<wire x1="58.42" y1="27.94" x2="53.34" y2="27.94" width="0.1524" layer="91"/>
<label x="53.34" y="27.94" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="D6" gate="G$1" pin="C"/>
<wire x1="58.42" y1="15.24" x2="53.34" y2="15.24" width="0.1524" layer="91"/>
<label x="53.34" y="15.24" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="D7" gate="G$1" pin="C"/>
<wire x1="58.42" y1="2.54" x2="53.34" y2="2.54" width="0.1524" layer="91"/>
<label x="53.34" y="2.54" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="D8" gate="G$1" pin="C"/>
<wire x1="58.42" y1="-10.16" x2="53.34" y2="-10.16" width="0.1524" layer="91"/>
<label x="53.34" y="-10.16" size="1.778" layer="95"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
<compatibility>
<note version="8.2" severity="warning">
Since Version 8.2, EAGLE supports online libraries. The ids
of those online libraries will not be understood (or retained)
with this version.
</note>
<note version="8.3" severity="warning">
Since Version 8.3, EAGLE supports URNs for individual library
assets (packages, symbols, and devices). The URNs of those assets
will not be understood (or retained) with this version.
</note>
<note version="8.3" severity="warning">
Since Version 8.3, EAGLE supports the association of 3D packages
with devices in libraries, schematics, and board files. Those 3D
packages will not be understood (or retained) with this version.
</note>
</compatibility>
</eagle>
