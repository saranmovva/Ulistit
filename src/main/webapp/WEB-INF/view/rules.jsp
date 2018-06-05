<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<spring:url value="resources/js/jquery.js" var="jquery" />
<spring:url value="resources/css/uikit.css" var="uikitCSS" />
<spring:url value="resources/js/uikit.js" var="uikitJS" />
<spring:url value="resources/js/uikit-icons.js" var="uikiticons" />

<link href="${uikitCSS}" rel="stylesheet" />
<script type="text/javascript" src="${jquery}"></script>
<script type="text/javascript" src="${uikitJS}"></script>
<script type="text/javascript" src="${uikiticons}"></script>
<style>
.big {
	height: 2000px;
	font-weight: bold;
}

.uk-nav-default li {
	margin-top: 1px;
	padding-left: 8px;
	border-left: 8px solid #CCC;
	-webkit-transition: border-color 250ms ease;
	transition: border-color 250ms ease;
}

.uk-nav-default li.uk-active {
	border-left-color: #369;
}
</style>
</head>
<body style="background-color: rgba(36, 143, 203, 0.08);">

	<%@include file="jspf/navbar.jspf"%>

	<div class="uk-section">
		<div class="uk-container">
			<div uk-grid="">
				<div class="uk-width-2-3">
					<div class="big">
						<h2 id="link1">
							<em>Bidding</em>
						</h2>
						<p>Lorem ipsum dolor sit amet consectetur adipiscing elit
							faucibus, in nisl pharetra orci iaculis litora viverra dapibus,
							semper leo ad augue rutrum lacinia placerat. Ornare pulvinar
							potenti porta quam luctus diam placerat sociis, augue vivamus
							interdum non vehicula aliquet pharetra morbi, ultricies et
							faucibus integer mi urna blandit. Faucibus dictum condimentum
							lectus erat integer hac sagittis, dapibus dignissim neque
							senectus per non convallis, suspendisse cum curabitur tempor
							pharetra pretium. Scelerisque nam primis dui eu at penatibus cras
							velit, taciti sollicitudin hac sed cursus mi senectus feugiat
							enim, tincidunt nullam aptent vitae convallis nisl rutrum. Magnis
							morbi a vulputate luctus class etiam cum gravida inceptos est
							ultricies per pellentesque aptent quis egestas, quisque integer
							cras nec proin nostra ultrices leo volutpat commodo pretium non
							ligula felis accumsan. Justo mauris vel tellus velit tristique
							tempor libero ultricies condimentum, blandit torquent massa
							consequat id feugiat diam vulputate cursus, dapibus natoque
							ridiculus donec vitae molestie tincidunt nisl. Imperdiet dictumst
							convallis maecenas nullam habitant torquent scelerisque ac
							potenti, dis purus dapibus dictum cubilia tempor velit facilisis
							varius, interdum vestibulum hac ante integer aptent pulvinar
							aliquam. Morbi platea lacinia dui nibh purus odio tempus
							suspendisse, luctus accumsan per turpis volutpat aliquam
							fringilla nunc, est sociis litora natoque neque sodales
							vestibulum conubia, id mattis senectus torquent venenatis sapien
							mollis.</p>
					</div>
					<hr />
					<div class="big">
						<h2 id="link2">
							<em>Auctions</em>
						</h2>
						<p>Lorem ipsum dolor sit amet consectetur adipiscing elit
							faucibus, in nisl pharetra orci iaculis litora viverra dapibus,
							semper leo ad augue rutrum lacinia placerat. Ornare pulvinar
							potenti porta quam luctus diam placerat sociis, augue vivamus
							interdum non vehicula aliquet pharetra morbi, ultricies et
							faucibus integer mi urna blandit. Faucibus dictum condimentum
							lectus erat integer hac sagittis, dapibus dignissim neque
							senectus per non convallis, suspendisse cum curabitur tempor
							pharetra pretium. Scelerisque nam primis dui eu at penatibus cras
							velit, taciti sollicitudin hac sed cursus mi senectus feugiat
							enim, tincidunt nullam aptent vitae convallis nisl rutrum. Magnis
							morbi a vulputate luctus class etiam cum gravida inceptos est
							ultricies per pellentesque aptent quis egestas, quisque integer
							cras nec proin nostra ultrices leo volutpat commodo pretium non
							ligula felis accumsan. Justo mauris vel tellus velit tristique
							tempor libero ultricies condimentum, blandit torquent massa
							consequat id feugiat diam vulputate cursus, dapibus natoque
							ridiculus donec vitae molestie tincidunt nisl. Imperdiet dictumst
							convallis maecenas nullam habitant torquent scelerisque ac
							potenti, dis purus dapibus dictum cubilia tempor velit facilisis
							varius, interdum vestibulum hac ante integer aptent pulvinar
							aliquam. Morbi platea lacinia dui nibh purus odio tempus
							suspendisse, luctus accumsan per turpis volutpat aliquam
							fringilla nunc, est sociis litora natoque neque sodales
							vestibulum conubia, id mattis senectus torquent venenatis sapien
							mollis.</p>
					</div>
					<hr />
					<div class="big">
						<h2 id="link3">
							<em>Buying/Selling</em>
						</h2>
						<p>Lorem ipsum dolor sit amet consectetur adipiscing elit
							faucibus, in nisl pharetra orci iaculis litora viverra dapibus,
							semper leo ad augue rutrum lacinia placerat. Ornare pulvinar
							potenti porta quam luctus diam placerat sociis, augue vivamus
							interdum non vehicula aliquet pharetra morbi, ultricies et
							faucibus integer mi urna blandit. Faucibus dictum condimentum
							lectus erat integer hac sagittis, dapibus dignissim neque
							senectus per non convallis, suspendisse cum curabitur tempor
							pharetra pretium. Scelerisque nam primis dui eu at penatibus cras
							velit, taciti sollicitudin hac sed cursus mi senectus feugiat
							enim, tincidunt nullam aptent vitae convallis nisl rutrum. Magnis
							morbi a vulputate luctus class etiam cum gravida inceptos est
							ultricies per pellentesque aptent quis egestas, quisque integer
							cras nec proin nostra ultrices leo volutpat commodo pretium non
							ligula felis accumsan. Justo mauris vel tellus velit tristique
							tempor libero ultricies condimentum, blandit torquent massa
							consequat id feugiat diam vulputate cursus, dapibus natoque
							ridiculus donec vitae molestie tincidunt nisl. Imperdiet dictumst
							convallis maecenas nullam habitant torquent scelerisque ac
							potenti, dis purus dapibus dictum cubilia tempor velit facilisis
							varius, interdum vestibulum hac ante integer aptent pulvinar
							aliquam. Morbi platea lacinia dui nibh purus odio tempus
							suspendisse, luctus accumsan per turpis volutpat aliquam
							fringilla nunc, est sociis litora natoque neque sodales
							vestibulum conubia, id mattis senectus torquent venenatis sapien
							mollis.</p>
					</div>
					<hr />
					<div class="big">
						<h2 id="link4">
							<em>Disputes</em>
						</h2>
						<p>Lorem ipsum dolor sit amet consectetur adipiscing elit
							faucibus, in nisl pharetra orci iaculis litora viverra dapibus,
							semper leo ad augue rutrum lacinia placerat. Ornare pulvinar
							potenti porta quam luctus diam placerat sociis, augue vivamus
							interdum non vehicula aliquet pharetra morbi, ultricies et
							faucibus integer mi urna blandit. Faucibus dictum condimentum
							lectus erat integer hac sagittis, dapibus dignissim neque
							senectus per non convallis, suspendisse cum curabitur tempor
							pharetra pretium. Scelerisque nam primis dui eu at penatibus cras
							velit, taciti sollicitudin hac sed cursus mi senectus feugiat
							enim, tincidunt nullam aptent vitae convallis nisl rutrum. Magnis
							morbi a vulputate luctus class etiam cum gravida inceptos est
							ultricies per pellentesque aptent quis egestas, quisque integer
							cras nec proin nostra ultrices leo volutpat commodo pretium non
							ligula felis accumsan. Justo mauris vel tellus velit tristique
							tempor libero ultricies condimentum, blandit torquent massa
							consequat id feugiat diam vulputate cursus, dapibus natoque
							ridiculus donec vitae molestie tincidunt nisl. Imperdiet dictumst
							convallis maecenas nullam habitant torquent scelerisque ac
							potenti, dis purus dapibus dictum cubilia tempor velit facilisis
							varius, interdum vestibulum hac ante integer aptent pulvinar
							aliquam. Morbi platea lacinia dui nibh purus odio tempus
							suspendisse, luctus accumsan per turpis volutpat aliquam
							fringilla nunc, est sociis litora natoque neque sodales
							vestibulum conubia, id mattis senectus torquent venenatis sapien
							mollis.</p>
					</div>
					<hr />
					<div class="big">
						<h2 id="link5">
							<em>Meetups</em>
						</h2>
						<p>Lorem ipsum dolor sit amet consectetur adipiscing elit
							faucibus, in nisl pharetra orci iaculis litora viverra dapibus,
							semper leo ad augue rutrum lacinia placerat. Ornare pulvinar
							potenti porta quam luctus diam placerat sociis, augue vivamus
							interdum non vehicula aliquet pharetra morbi, ultricies et
							faucibus integer mi urna blandit. Faucibus dictum condimentum
							lectus erat integer hac sagittis, dapibus dignissim neque
							senectus per non convallis, suspendisse cum curabitur tempor
							pharetra pretium. Scelerisque nam primis dui eu at penatibus cras
							velit, taciti sollicitudin hac sed cursus mi senectus feugiat
							enim, tincidunt nullam aptent vitae convallis nisl rutrum. Magnis
							morbi a vulputate luctus class etiam cum gravida inceptos est
							ultricies per pellentesque aptent quis egestas, quisque integer
							cras nec proin nostra ultrices leo volutpat commodo pretium non
							ligula felis accumsan. Justo mauris vel tellus velit tristique
							tempor libero ultricies condimentum, blandit torquent massa
							consequat id feugiat diam vulputate cursus, dapibus natoque
							ridiculus donec vitae molestie tincidunt nisl. Imperdiet dictumst
							convallis maecenas nullam habitant torquent scelerisque ac
							potenti, dis purus dapibus dictum cubilia tempor velit facilisis
							varius, interdum vestibulum hac ante integer aptent pulvinar
							aliquam. Morbi platea lacinia dui nibh purus odio tempus
							suspendisse, luctus accumsan per turpis volutpat aliquam
							fringilla nunc, est sociis litora natoque neque sodales
							vestibulum conubia, id mattis senectus torquent venenatis sapien
							mollis.</p>
					</div>
					<hr />
					<div class="big">
						<h2 id="link6">
							<em>Messaging</em>
						</h2>
						<p>Lorem ipsum dolor sit amet consectetur adipiscing elit
							faucibus, in nisl pharetra orci iaculis litora viverra dapibus,
							semper leo ad augue rutrum lacinia placerat. Ornare pulvinar
							potenti porta quam luctus diam placerat sociis, augue vivamus
							interdum non vehicula aliquet pharetra morbi, ultricies et
							faucibus integer mi urna blandit. Faucibus dictum condimentum
							lectus erat integer hac sagittis, dapibus dignissim neque
							senectus per non convallis, suspendisse cum curabitur tempor
							pharetra pretium. Scelerisque nam primis dui eu at penatibus cras
							velit, taciti sollicitudin hac sed cursus mi senectus feugiat
							enim, tincidunt nullam aptent vitae convallis nisl rutrum. Magnis
							morbi a vulputate luctus class etiam cum gravida inceptos est
							ultricies per pellentesque aptent quis egestas, quisque integer
							cras nec proin nostra ultrices leo volutpat commodo pretium non
							ligula felis accumsan. Justo mauris vel tellus velit tristique
							tempor libero ultricies condimentum, blandit torquent massa
							consequat id feugiat diam vulputate cursus, dapibus natoque
							ridiculus donec vitae molestie tincidunt nisl. Imperdiet dictumst
							convallis maecenas nullam habitant torquent scelerisque ac
							potenti, dis purus dapibus dictum cubilia tempor velit facilisis
							varius, interdum vestibulum hac ante integer aptent pulvinar
							aliquam. Morbi platea lacinia dui nibh purus odio tempus
							suspendisse, luctus accumsan per turpis volutpat aliquam
							fringilla nunc, est sociis litora natoque neque sodales
							vestibulum conubia, id mattis senectus torquent venenatis sapien
							mollis.</p>
					</div>
					<hr />
				</div>
				<div class="uk-width-1-3">
					<div class="uk-float-right">
						<div uk-sticky="offset:25">
							<ul class="uk-nav uk-nav-default"
								uk-scrollspy-nav="closest:li;scroll:true;offset:25">
								<li><a href="#link1">Bidding</a></li>
								<li><a href="#link2">Auctions</a></li>
								<li><a href="#link3">Buying/Selling</a></li>
								<li><a href="#link4">Disputes</a></li>
								<li><a href="#link5">Meetups</a></li>
								<li><a href="#link6">Messaging</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>