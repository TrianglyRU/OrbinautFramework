![banner](https://github.com/TrianglyRU/OrbinautFramework2/assets/45323263/9e802204-355f-4a26-a3d2-28f7aa8eff54)

## About
 
Orbinaut Framework 2 is the successor to the original Orbinaut Framework, a classic Sonic framework created for GameMaker. It prioritises ease-of-use and has a certain level of templating at its core (as it basically should), making it friendly for both beginners and advanced users.
Orbinaut is written from scratch and everything here is new.

## Framework Documentation & Installation

Orbinaut Framework 2 features comprehensive documentation available in the [Wiki](https://github.com/TrianglyRU/OrbinautFramework/wiki) section. Even if you feel like you can skip it, make sure to read the [installation guide](https://github.com/TrianglyRU/OrbinautFramework/wiki#installation) — the project has a critical dependency, and the game **will not compile** without it!

## Basic Features

- Uniqueness: The framework contains its own solutions that replace some features of GameMaker, simplifying the development process, particularly for Sonic games.
- Performance: While being slower than its predecessor due to a higher amount of things working behind the scenes, if used intelligently, the framework can reach high enough speeds thanks to its architecture and optimisation (within the GameMaker limitations).

Although the framework is designed to match the look and feel of the original four classic Sonic titles, it can be adapted to create non-Sonic gameplay due to its design.

## Sonic Features

- All gameplay objects in the framework provided by default are aimed to be accurate to their Sonic 2 presentation, code and animation-wise.
- Character physics, character-to-object and object-to-terrain collisions are faithfully recreated to provide similar or the same result as in the original games, making it one of the most accurate classic Sonic frameworks ever made, if this is what you're looking for.
- Four playable characters are available: Sonic, Tails, Knuckles, and Amy.
- Support for multiple player objects, which can be set up to be controlled by either a computer or a real person.
- Up to 8 player splitscreen support.¹
- The ability to customise gameplay by toggling various differences between the four classic titles, ensuring you get the experience you want to have in your game.
- The framework offers various graphical effects you can see in the classic games, including its own background parallax, palette rotation, palette-based fade in/out and screen distortions.
- Overall, most methods are accurate or similar to the ones used in the original Sonic engine.

## Future Plans & Support

The framework is fully complete, with all features functional² and ready to use, so **no further updates** will be released. While we wait for the LTS release, the repository will only be updated if something breaks or stops working after a new runtime or IDE version is released. In such cases, if you are already working on your project, you can manually fix your local project by following the change log.

If you have any questions about the framework, feel free to use the [Discussions](https://github.com/TrianglyRU/OrbinautFramework/discussions) tab. All major news will be posted there and on Twitter.

## Credits

- **Project Lead**: Triangly
- **Programmers**: Triangly, Michael Gallinago, techncolour
- **Framework Branding & Sprite Edits**: Natufox
- **Framework Trailer**: Lapper, Triangly
- **Tech Stadium Zone**: Enrico Cartmanuel
- **Level Design**: FieryN8
- **"Giganorbi" Boss Programming**: techncolour
- **Special Thanks**: Lapper, Mercury, NicoCW, Valeev, Noah N. Copeland, The Sonic 1, 2 and 3 Dissasembly Community, @RunningPigeon, and our Twitter followers!

---

¹ Default splitscreen support is basic, providing separate screens for CPUs that can be taken under control like in Sonic 2 or Sonic 3(K). There is no "complete splitscreen experience", as you may call it that.    

² The distortion effect does not work correctly right now (and therefore is disabled) due to the latest GameMaker update. The problem is not on our side and we're waiting for the fix.​
