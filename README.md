# Keepcoding Startup Engineering Master Bootcamp III #

## Practica Superpoderes iOS## 


**ComicList - RxSwift / Realm**

###Fix the VolumeDetailsViewModel with Issues 
***
1. `ComicService` protocol

	* Add the `VolumeDescription` struct
	* Implement the `JSONDecodable` protocol for `VolumeDescription`
	* Add the case `issues` in the enum `API`

2. `ComicList` app

	* Implement the `JSONDecodable` protocol for `Issue` struct
	* Change the implementation of `isues` var in the VolumeDetailsViewModel


###Add Realm wrapper to ComicContainer framework
***
1. Add `Realm` Framework to project
2. Add `VolumeContainerRealm`, `VolumeEntryRealm` and `VolumeResultsRealm` into `ComicContainer` framework
3. Implement `VolumeContainerType` protocol
4. Implement `VolumeResultsType` protocol
5. Change calls in `ComicList` project of CoreData classes to Realm Classes
6. Add in `VolumeContainer+List` file a property instance for `VolumenContainerRealm`