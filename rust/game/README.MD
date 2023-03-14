# Game Test

## Basics about game engines

With the Game engine [Amethyst](https://amethyst.rs/doc), a [data-driven
game engine written](https://gamedevelopment.tutsplus.com/articles/what-is-data-oriented-game-engine-design--cms-21052) in Rust

- A data-driven game engine is basically: *construct you code around the data structures and describe what you want to achieve in terms of manipulation of these structures*

- Flexibility: Game logic and data can be easily modified without having to change the engine code, making it easier to iterate on the game design.

- Reusability: The same engine code can be used for multiple games or game genres, as long as the data files are written correctly.

- Separation of concerns: The core engine code can be focused on performance and stability, while game-specific logic and data can be handled by the external data files.

- Easier to maintain: The engine code can be kept separate from game-specific code, making it easier to maintain and update the engine over time.

Some Concepts behind Amethyst

### State

it's used to represent the game state, a game state is a *general* and *global* section of the game

- State Manager
  - Amethyst has a built-in state manager, which allows easily switching between different States. It is based on the concept of a pushdown-automaton, which is a combination of a Stack and a State Machine
    - Stack
      - The stack concept makes it so you can "push" States on top of each other.

      - If we take the pong example of earlier, you can push the PauseState over the GameplayState.

      - When you want to go out of pause, you pop the PauseState out of the stack and you are back into the GameplayState, just as you left it.

    - State Machine
      - The concept of State Machine can be pretty complex, but here we will only explain the basics of it. The State Machine is usually composed of two elements: Transitions and Events.

      - Transitions are simply the "switching" between two states.

      - For example, from LoadingState, go to state MainMenuState.

      - Amethyst has multiple types of transitions.

        - You can Push a State over another.
        - You can also Switch a State, which replaces the current State with a new one.

      - Events are what trigger the transitions. In the case of amethyst, it is the different methods called on the State. Continue reading to learn about them.
  
- Life Cycle
  - States are only valid for a certain period of time, during which a lot of things can occur. A State contains methods that reflect the most common of those events:

    - on_start: When a State is added to the stack, this method is called on it.  
    - on_stop: When a State is removed from the stack, this method is called on it.
    - on_pause: When a State is pushed over the current one, the current one is paused, and this method is called on it.
    - on_resume: When the State that was pushed over the current State is popped, the current one resumes, and this method is called on the now-current State.
    - handle_event: Allows easily handling events, like the window closing or a key being pressed.
    - fixed_update: This method is called on the active State at a fixed time interval (1/60th second by default).
    - update: This method is called on the active State as often as possible by the engine.
    - shadow_update: This method is called as often as possible by the engine on all States which are on the StateMachines stack, including the active State. Unlike update, this does not return a Trans.
    - shadow_fixed_update: This method is called at a fixed time interval (1/60th second by default) on all States which are on the StateMachines stack, including the active State. Unlike fixed_update, this does not return a Trans.
  - If you aren't using SimpleState or EmptyState, you must implement the update method to call data.data.update(&mut data.world)

- Game Data
  - States can have arbitrary data associated with them. If you need to store data that is tightly coupled to your State, the classic way is to put it in the State's struct.

  - States also have internal data, which is any type T. In most cases, the two following are the most used: () and GameData.

  - () means that there is no data associated with this State. This is usually used for tests and not for actual games. GameData is the de-facto standard. It is a struct containing a Dispatcher. This will be discussed later.

  - When calling your State's methods, the engine will pass a StateData struct which contains both the World (which will also be discussed later) and the Game Data type that you chose.

### What are entity and components?

An Entity represents a single object in your world. Component represents one aspect of an object. For example, a bottle of water has a shape, a volume, a color and is made of a material (usually plastic). In this example, the bottle is the entity, and the properties are components.

- Entity and Component in Amethyst
  - In an inheritance design, entity usually contains components. All the data and methods related to an entity are stored within. However, in the ECS design, entity is just a general purpose object. In fact, the implementation of Entity in Amethyst is simply:

  ```Rust
    struct Entity(u32, Generation);
  ```

- EntitiesRes

  - Even though the structure of the entity is pretty simple, entity manipulation is very sophisticated and crucial to game performance. This is why entities are handled exclusively by the struct EntitiesRes. EntitiesRes provides two ways for creating/deleting entities:

    - Immediate creation/deletion, used for game setup or clean up.
    - Lazy creation/deletion, used in the game play state. It updates entities in batch at the end of each game loop. This is also referred to as atomic creation/deletion.
  
  - You will see how these methods are used in later chapters.

- Declaring a component
  - To declare a component, you first declare the relevant underlying data:

  ```Rust
  extern crate amethyst;

  use amethyst::core::math::{Isometry3, Vector3};

  /// This `Component` describes the shape of an `Entity`
  enum Shape {
      Sphere { radius: f32 },
      Cuboid { height: f32, width: f32, depth: f32 },
  }

  /// This `Component` describes the transform of an `Entity`
  pub struct Transform {
      /// Translation + rotation value
      iso: Isometry3<f32>,
      /// Scale vector
      scale: Vector3<f32>,
  }
  ```

  - and then you implement the Component trait for them:

  ```Rust
  use amethyst::ecs::{Component, DenseVecStorage, FlaggedStorage};

  impl Component for Shape {
      type Storage = DenseVecStorage<Self>;
  }

  impl Component for Transform {
      type Storage = FlaggedStorage<Self, DenseVecStorage<Self>>;
  }
  ```

  - The storage type will determine how you store the component, but it will not initialize the storage. Storage is initialized when you register a component in World or when you use that component in a System.

- Storages
  - here are a few storage strategies for different usage scenarios. The most commonly used types are DenseVecStorage, VecStorage and FlaggedStorage.

    - DenseVecStorage: Elements are stored in a contiguous vector. No empty space is left between Components, allowing a lowered memory usage for big components.

    - VecStorage: Elements are stored into a sparse array. The entity id is the same as the index of component. If your component is small (<= 16 bytes) or is carried by most entities, this is preferable over DenseVecStorage.

    - FlaggedStorage: Used to keep track of changes of a component. Useful for caching purposes.

- Tag
  - Components can also be used to "tag" entities. The usual way to do it is to create an empty struct, and implement Component using NullStorage as the Storage type for it. Null storage means that it is not going to take memory space to store those components.

### Resource

- What is a resource?

  - A resource is any type that stores data that you might need for your game AND that is not specific to an entity. For example, the score of a pong game is global to the whole game and isn't owned by any of the entities (paddle, ball and even the ui score text).

- Creating a resource

  - Resources are stored in the World container
  - Adding a resource to a World instance is done like this:
  
  ```Rust
    struct MyResource {
      pub game_score: i32,
  }

  fn main() {
      let mut world = World::empty();
      
      let my = MyResource {
          game_score: 0,
      };
      
      world.insert(my);
  }
  ```

- Fetching a resource (from world)

  - Fetching a resource can be done like this:

  ```Rust
  // try_fetch returns a Option<Fetch<MyResource>>
  let fetched = world.try_fetch::<MyResource>();
  if let Some(fetched_resource) = fetched {
      //dereference Fetch<MyResource> to access data
      assert_eq!(*fetched_resource, MyResource{ game_score: 0, });
  } else {
      println!("No MyResource present in `World`");
  }
  ```

  - If you want to get a resource and create it if it doesn't exist:

  ```Rust
  // If the resource isn't inside `World`, 
  // it will insert the instance we created earlier.
  let fetched = world.entry::<MyResource>().or_insert_with(|| my);
  ```

  - If you want to change a resource that is already inside of World:

  ```Rust
  // try_fetch_mut returns a Option<FetchMut<MyResource>>
  let fetched = world.try_fetch_mut::<MyResource>();
  if let Some(mut fetched_resource) = fetched {
    assert_eq!(fetched_resource.game_score, 0);
    fetched_resource.game_score = 10;
    assert_eq!(fetched_resource.game_score, 10);
  } else {
    println!("No MyResource present in `World`");
  }
  ```

  - Other ways of fetching a resource will be covered in the system section of the book.

- Deleting a resource
  - There is no method to properly "delete" a resource added to the world. The usual method to achieve something similar is to add an ```Option<MyResource>``` and to set it to None when you want to delete it.

- Storages, part 2
  - A Component's Storage is a resource. The components are "attached" to entities, but as said previously, they are not "owned" by the entities at the implementation level. By storing them into Storages and by having Storage be placed inside World, it allows global access to all of the components at runtime with minimal effort.

  - Actually accessing the components inside Storages will be covered in the world and system sections of the book.

  - WARNING: If you try to fetch the component directly, you will not get the storage. You will get a Default::default() instance of that component. To get the Storage resource that HOLDS all the MyComponent instances, you need to fetch ```ReadStorage<MyComponent>```.

### World

- What is a world?
  - A world is a container for resources, with some helper functions that make you life easier. This chapter will showcase those functions and their usage

- Adding a resource

  ```Rust
  use amethyst::ecs::{World, WorldExt};
  // A simple struct with no data.
  struct MyResource;

  fn main() {
      // We create a new `World` instance.
      let mut world = World::new();
      
      // We create our resource.
      let my = MyResource;
      
      // We add the resource to the world.
      world.insert(my);
  }
  ```

- Fetching a resource
  - Here's how to fetch a read-only resource. Be Aware that this method panics if the resource isn't inserted into Resources.
  
  ```Rust
  let my = world.read_resource::<MyResource>();
  ```

  - If you are not sure that the resource will be present, use the methods available on Resources, as shown in the resource chapter

  ```Rust
  let my = world.entry::<MyResource>().or_insert_with(|| MyResource);
  ```

- Modifying a resource

  ```Rust
  let mut my = world.write_resource::<MyResource>();
  ```

- Creating Entities
  
  - You first start by creating the entity builder. Then, you can add components to your entity. Finally, you call the build() method on the entity builder to get the actual entity. Please note that in order to use this syntax, you need to import the `amethyst::prelude::Builder` trait.

  ```Rust
    world.register::<MyComponent>();
    use amethyst::prelude::Builder;

    let mut entity_builder = world.create_entity();
    entity_builder = entity_builder.with(MyComponent);
    let my_entity = entity_builder.build();
  ```
  
  - shorter version:

  ```Rust
  extern crate amethyst;
  use amethyst::ecs::{World, WorldExt};
  struct MyComponent;
  impl amethyst::ecs::Component for MyComponent {
    type Storage = amethyst::ecs::VecStorage<MyComponent>;
  }

  fn main() {
    let mut world = World::new();
      use amethyst::prelude::Builder;

      let my_entity = world
        .create_entity()
        .with(MyComponent)
        .build();
  }
  ```

  - Accessing a Component

  ```Rust
  extern crate amethyst;
  use amethyst::ecs::{Builder, World, WorldExt};
  struct MyComponent;
  impl amethyst::ecs::Component for MyComponent {
    type Storage = amethyst::ecs::VecStorage<MyComponent>;
  }
  fn main() {
    let mut world = World::new();
      // Create an `Entity` with `MyComponent`.
      // `World` will implicitly write to the component's storage in `Resources`.
      let my_entity = world.create_entity().with(MyComponent).build();
      
      // Get a ReadStorage<MyComponent>
      let storage = world.read_storage::<MyComponent>();
      
      // Get the actual component from the storage.
      let my = storage.get(my_entity).expect("Failed to get component for entity");
  }

  ```

  - Modifying a component

    - This is almost the same as accessing a component

    ```Rust
    extern crate amethyst;
    use amethyst::ecs::{Builder, World, WorldExt};
    struct MyComponent;
    impl amethyst::ecs::Component for MyComponent {
      type Storage = amethyst::ecs::VecStorage<MyComponent>;
    }
    fn main() {
      let mut world = World::new();
        let my_entity = world.create_entity().with(MyComponent).build();
        let mut storage = world.write_storage::<MyComponent>();
        let mut my = storage.get_mut(my_entity).expect("Failed to get component for entity");
    }

    ```

  - Getting all entities

    - It is pretty rare to use this, but can be useful in some occasions.

    ```Rust
    extern crate amethyst;
    use amethyst::ecs::{World, WorldExt};
    fn main() {
      let mut world = World::new();
        // Returns `EntitiesRes`
        let entities = world.entities();
    }
    ```

  - Delete an entity
    - Single:

    ```Rust
    world.delete_entity(my_entity).expect("Failed to delete entity. Was it already removed?");
    ```

    - Multiple:

    ```Rust
    world.delete_entities(entity_vec.as_slice()).expect("Failed to delete entities from specified list.");
    ```

    - All:

    ```Rust
    world.delete_all();
    ```

    - Note: Entities are lazily deleted, which means that deletion only happens at the end of the frame and not immediately when calling the delete method.

  - Check if the entity was deleted

    ```Rust
    // Returns true if the entity was **not** deleted.
    let is_alive = world.is_alive(my_entity);
    ```
  
  - Exec

    - This is just to show that this feature exists. It is normal to not understand what it does until you read the system chapter

    - Sometimes, you will want to create an entity where you need to fetch resources to create the correct components for it. There is a function that acts as a shorthand for this:

    ```Rust
    world.exec(|mut data: SomeSystemData| {
        data.do_something();
    });
    ```

    - We will talk about what SystemData is in the system chapter.

### System

- What is a system

  - A system is where the logic of the game is executed. In practice, it consists of a struct implementing a function executed on every iteration of the game loop, and taking as an argument data about the game.

  - Systems can be seen as a small unit of logic. All systems are run by the engine together (even in parallel when possible), and do a specialized operation on one or a group of entities.

- Structure

  - A system struct is a structure implementing the trait `amethyst::ecs::System`

  - Here is a very simple example implementation:

  ```Rust
  struct MyFirstSystem;

  impl<'a> System<'a> for MyFirstSystem {
      type SystemData = ();

      fn run(&mut self, data: Self::SystemData) {
          println!("Hello!");
      }
  }
  ```
  
  - This system will, on every iteration of the game loop, print "Hello!" in the console. This is a pretty boring system as it does not interact at all with the game. Let us spice it up a bit.

- Accessing the context of the game
  
  - In the definition of a system, the trait requires you to define a type SystemData. This type defines what data the system will be provided with on each call of its run method. SystemData is only meant to carry information accessible to multiple systems. Data local to a system is usually stored in the system's struct itself instead.

  - The Amethyst engine provides useful system data types to use in order to access the context of a game. Here are some of the most important ones:

    - Read<'a, Resource> (respectively Write<'a, Resource>) allows you to obtain an immutable (respectively mutable) reference to a resource of the type you specify. This is guaranteed to not fail as if the resource is not available, it will give you the Default::default() of your resource.

    - ReadExpect<'a, Resource> (respectively WriteExpect<'a, Resource>) is a failable alternative to the previous system data, so that you can use resources that do not implement the Default trait.

    - ReadStorage<'a, Component> (respectively WriteStorage<'a, Component>) allows you to obtain an immutable (respectively mutable) reference to the entire storage of a certain Component type.

    - Entities<'a> allows you to create or destroy entities in the context of a system.
  
  - You can then use one, or multiple of them via tuple

    ```Rust
      struct MyFirstSystem;

      impl<'a> System<'a> for MyFirstSystem {
          type SystemData = Read<'a, Time>;

          fn run(&mut self, data: Self::SystemData) {
              println!("{}", data.delta_seconds());
          }
      }

  - Here, we get the ```amethyst::core::timing::Time``` resource to print in the console the time elapsed between two frames. Nice! But that's still a bit boring.

- Manipulation storages

  - Once you have access to storage, you can use them in different ways

  - Getting a component of a specific entity

    ```Rust
    struct WalkPlayerUp {
        player: Entity,
    }

    impl<'a> System<'a> for WalkPlayerUp {
        type SystemData = WriteStorage<'a, Transform>;

        fn run(&mut self, mut transforms: Self::SystemData) {
            transforms.get_mut(self.player).unwrap().prepend_translation_y(0.1);
        }
    }
    ```

  - This system makes the player go up by 0.1 unit every iteration of the game loop! To identify what entity the player is, we stored it beforehand in the system's struct. Then, we get its Transform from the transform storage, and move it along the Y axis by 0.1.

  > A transform is a very common structure in game development. It represents the position, rotation and scale of an object in the game world. You will use them a lot, as they are what you need to change when you want to move something around in your game.

  - However, this approach is pretty rare because most of the time you don't know what entity you want to manipulate, and in fact you may want to apply your changes to multiple entities.

- Getting entities that have some components, but not others

  - There is a special type of Storage in specs called AntiStorage. The not operator (!) turns a Storage into its AntiStorage counterpart, allowing you to iterate over entities that do NOT have this Component. It is used like this:

    ```Rust
      use amethyst::ecs::Join;

      struct NotFallingObjects;

      impl<'a> System<'a> for NotFallingObjects {
          type SystemData = (
              WriteStorage<'a, Transform>,
              ReadStorage<'a, FallingObject>,
          );

          fn run(&mut self, (mut transforms, falling): Self::SystemData) {
              for (mut transform, _) in (&mut transforms, !&falling).join() {
                  // If they don't fall, why not make them go up!
                  transform.prepend_translation_y(0.1);
              }
          }
      }
    ```

- Manipulating the structure of entities

  - It may sometimes be interesting to manipulate the structure of entities in a system, such as creating new ones or modifying the component layout of existing ones. This kind of process is done using the Entities<'a> system data.

  > Requesting Entities<'a> does not impact performance, as it contains only immutable resources and therefore does not block the dispatching.

- Creating new entities in a system

  - Creating an entity while in the context of a system is very similar to the way one would create an entity using the World struct. The only difference is that one needs to provide mutable storages of all the components they plan to add to the entity.

    ```Rust
      struct SpawnEnemies {
      counter: u32,
    }

    impl<'a> System<'a> for SpawnEnemies {
        type SystemData = (
            WriteStorage<'a, Transform>,
            WriteStorage<'a, Enemy>,
            Entities<'a>,
        );

        fn run(&mut self, (mut transforms, mut enemies, entities): Self::SystemData) {
            self.counter += 1;
            if self.counter > 200 {
                entities.build_entity()
                    .with(Transform::default(), &mut transforms)
                    .with(Enemy, &mut enemies)
                    .build();
                self.counter = 0;
            }
        }
    }
    ```

  - This system will spawn a new enemy every 200 game loop iterations

- Removing an entity

  - Deleting an entity is very easy using `Entities<'a>`
  
  ```Rust
    entities.delete(entity);
  ```

- Iterating over components with associated entity

  - Sometimes, when you iterate over components, you may want to also know what entity you are working with. To do that, you can use the joining operation with `Entities<'a>.`

    ```Rust
      struct MakeObjectsFall;

      impl<'a> System<'a> for MakeObjectsFall {
          type SystemData = (
              Entities<'a>,
              WriteStorage<'a, Transform>,
              ReadStorage<'a, FallingObject>,
          );

          fn run(&mut self, (entities, mut transforms, falling): Self::SystemData) {
              for (e, mut transform, _) in (&*entities, &mut transforms, &falling).join() {
                  if transform.translation().y > 0.0 {
                      transform.prepend_translation_y(-0.1);
                  } else {
                      entities.delete(e);
                  }
              }
          }
      }
    ```

- Adding or removing components

  - You can also insert or remove components from a specific entity. To do that, you need to get a mutable storage of the component you want to modify, and simply do:

    ```Rust
      // Add the component
      write_storage.insert(entity, MyComponent);

      // Remove the component
      write_storage.remove(entity);
    ```

  - Keep in mind that inserting a component on an entity that already has a component of the same type will `overwrite the previous one.`

- Changing states through resources

  - In a previous section we talked about States, and how they are used to organize your game into different logical sections. Sometimes we want to trigger a state transition from a system. For example, if a player dies we might want to remove their entity and signal to the state machine to push a state that shows a "You Died" screen.

  - So how can we affect states from systems? There are a couple of ways, but this section will detail the easiest one: using a Resource.

  - Before that, let's just quickly remind ourselves what a resource is:

  > A Resource is any type that stores data that you might need for your game AND that is not specific to an entity.

  - The data in a resource is available both to systems and states. We can use this to our advantage

    - `GameplayState`: State in which the game is running
    - `GameMenuState`: State where the game is paused adn we interact with a game menu.
  
  - The following example shows how to keep track of which state we are currently in. This allows us to do a bit of conditional logic in our systems to determine what to do depending on which state is currently active, and manipulating the states by tracking user actions:

    ```Rust
    extern crate amethyst;
    use amethyst::prelude::*;

    #[derive(Clone, Copy, Debug, PartialEq, Eq)]
    enum CurrentState {
        MainMenu,
        Gameplay,
    }

    #[derive(Clone, Copy, Debug, PartialEq, Eq)]
    enum UserAction {
        OpenMenu,
        ResumeGame,
        Quit,
    }

    impl Default for CurrentState {
        fn default() -> Self {
            CurrentState::Gameplay
        }
    }

    struct Game {
        user_action: Option<UserAction>,
        current_state: CurrentState,
    }

    impl Default for Game {
        fn default() -> Self {
            Game {
                user_action: None,
                current_state: CurrentState::default(),
            }
        }
    }

    struct GameplayState;

    impl SimpleState for GameplayState {
        fn update(&mut self, data: &mut StateData<'_, GameData<'_, '_>>) -> SimpleTrans {
            // If the `Game` resource has been set up to go back to the menu, push
            // the menu state so that we go back.

            let mut game = data.world.write_resource::<Game>();

            if let Some(UserAction::OpenMenu) = game.user_action.take() {
                return Trans::Push(Box::new(GameMenuState));
            }

            Trans::None
        }

        fn on_resume(&mut self, mut data: StateData<'_, GameData<'_, '_>>) {
            // mark that the current state is a gameplay state.
            data.world.write_resource::<Game>().current_state = CurrentState::Gameplay;
        }
    }

    struct GameMenuState;

    impl SimpleState for GameMenuState {
        fn update(&mut self, data: &mut StateData<'_, GameData<'_, '_>>) -> SimpleTrans {
            let mut game = data.world.write_resource::<Game>();

            match game.user_action.take() {
                Some(UserAction::ResumeGame) => Trans::Pop,
                Some(UserAction::Quit) => {
                    // Note: no need to clean up :)
                    Trans::Quit
                },
                _ => Trans::None,
            }
        }

        fn on_resume(&mut self, mut data: StateData<'_, GameData<'_, '_>>) {
            // mark that the current state is a main menu state.
            data.world.write_resource::<Game>().current_state = CurrentState::MainMenu;
        }
    }    
    ```
  
  - Let's say we want the player to be able to press escape to enter the menu. We modify our input handler to map the `open_menu` action to `Esc`, and write the following system:

    ```Rust
        extern crate amethyst;
        #[derive(Clone, Copy, Debug, PartialEq, Eq)]
        enum CurrentState {
            MainMenu,
            Gameplay,
        }

        impl Default for CurrentState { fn default() -> Self { CurrentState::Gameplay } }

        #[derive(Clone, Copy, Debug, PartialEq, Eq)]
        enum UserAction {
            OpenMenu,
            ResumeGame,
            Quit,
        }

        struct Game {
            user_action: Option<UserAction>,
            current_state: CurrentState,
        }

        impl Default for Game {
            fn default() -> Self {
                Game {
                    user_action: None,
                    current_state: CurrentState::default(),
                }
            }
        }

        use amethyst::{
            prelude::*,
            ecs::{System, prelude::*},
            input::{InputHandler, StringBindings},
        };

        struct MyGameplaySystem;

        impl<'s> System<'s> for MyGameplaySystem {
            type SystemData = (
                Read<'s, InputHandler<StringBindings>>,
                Write<'s, Game>,
            );

            fn run(&mut self, (input, mut game): Self::SystemData) {
                match game.current_state {
                    CurrentState::Gameplay => {
                        let open_menu = input
                            .action_is_down("open_menu")
                            .unwrap_or(false);

                        // Toggle the `open_menu` variable to signal the state to
                        // transition.
                        if open_menu {
                            game.user_action = Some(UserAction::OpenMenu);
                        }
                    }
                    // do nothing for other states.
                    _ => {}
                }
            }
        }

    ```

  - Now whenever you are playing the game and you press the button associated with `open_menu` action, the `GameMenuState` will resume and the `GameplayState` will pause.

- The SystemData trait

  - While this rarely useful, it is possible create custom `SystemData` types.

  - The `Dispatcher` populates the `SystemData` on every call of the run method. To do that, your `SystemData` type must implement the trait `amethyst::ecs::SystemData` in order to have it be valid.

  - This is rather complicated trait to implement, fortunately Amethyst provides a derive macro for it, that can implement the trait to any struct as long as all its fields are `SystemData`. Most of the time however, you will not even need to implement it at all as you will be using `SystemData` structs provided by the engine.

  - Please note that tuples of structs implementing `SystemData` are themselves `SystemData`. This is very useful when you need to request multiple `SystemData` at once quickly.

  ```Rust
    extern crate amethyst;
    extern crate shred;
    #[macro_use] extern crate shred_derive;

    use amethyst::{
        ecs::{Component, Join, ReadStorage, System, SystemData, VecStorage, World, WriteStorage},
        shred::ResourceId,
    };

    struct FooComponent {
      stuff: f32,
    }
    impl Component for FooComponent {
      type Storage = VecStorage<FooComponent>;
    }

    struct BarComponent {
      stuff: f32,
    }
    impl Component for BarComponent {
      type Storage = VecStorage<BarComponent>;
    }

    #[derive(SystemData)]
    struct BazSystemData<'a> {
    field: ReadStorage<'a, FooComponent>,
    }

    impl<'a> BazSystemData<'a> {
      fn should_process(&self) -> bool {
          true
      }
    }

    #[derive(SystemData)]
    struct MySystemData<'a> {
        foo: ReadStorage<'a, FooComponent>,
        bar: WriteStorage<'a, BarComponent>,
        baz: BazSystemData<'a>,
    }

    struct MyFirstSystem;

    impl<'a> System<'a> for MyFirstSystem {
        type SystemData = MySystemData<'a>;

        fn run(&mut self, mut data: Self::SystemData) {
            if data.baz.should_process() {
                for (foo, mut bar) in (&data.foo, &mut data.bar).join() {
                    bar.stuff += foo.stuff;
                }
            }
        }
    }
  ```

### System Initialization

- Systems may need to access resources from the `World` in order to be instantiated. For example, obtaining a `ReaderId` to an `EventChannel` that exists in the `World`. When there is an existing event channel in the `World`, a `System` should register itself as a reader of that channel instead of replacing it, as that invalidates all other readers.

- In Amethyst, the `World` that the application begins with is populated with a number of default resources -- event channels, a thread pool, a frame limiter, and so on.

- Given the default resources begin with special limits, we need a way to pass the `System` initialization logic through to the application, including parameters to the `System`'s constructor. This is information the `SystemDesc` trait captures.

- For each `System`, an implementation of the `SystemDesc` trait specifies the logic to instantiate the `System`. For `Systems` that do not require special initialization logic, the `SystemDesc` derive automatically implements the `SystemDesc` trait on the system type itself:

  ```Rust
    extern crate amethyst;
    use amethyst::{
        core::SystemDesc,
        derive::SystemDesc,
        ecs::{System, SystemData, World},
    };

    #[derive(SystemDesc)]
    struct SystemName;

    impl<'a> System<'a> for SystemName {
        type SystemData = ();

        fn run(&mut self, data: Self::SystemData) {
            println!("Hello!");
        }
    }
  ```

- The `SystemDesc` derive page demonstrates the use cases supported by the `SystemDesc` derive. For more complex cases, the Implementing the `SystemDesc` Trait page explains how to implement the `SystemDesc` trait.

### Dispatcher

- What is a Dispatcher?

  - dispatcher are the heart of the ECS infrastructure. They are the executors that decide when the System will be executed so that they don't walk over each other
  
  - When a dispatcher is created, it is associated with the systems that it will execute. it then generates an execution plan that respects mutability rules while maximizing parallelism

- Respecting mutability rules

  - When a system wants to access a Storage or a resource, they can do so either mutably or immutably. This works just like in Rust: either only one system can request something mutably and no other system can access it, or multiple systems can request something but only immutably.

  - The dispatcher looks at all the SystemData in the systems and builds execution stages.

  - If you want to have the best performance possible, you should prefer immutable over mutable whenever it is possible. (Read instead of Write, ReadStorage instead of WriteStorage).

  - Note: Please however keep in mind that Write is still preferable to locks in most cases, such as Mutex or RwLock for example.

### Event Channel

- What is an event channel?

  - An EventChannel is a broadcast queue of events. Events may be any type that implements `Send + Sync + 'static`.

  - Typically. `EventChannels` are inserted as resources in the `World`

- Examples

  - Creating an event channel

    ```Rust
      extern crate amethyst;
      use amethyst::shrev::EventChannel;
      // In the following examples, `MyEvent` is the event type of the channel.
      #[derive(Debug)]
      pub enum MyEvent {
          A,
          B,
      }

      let mut channel = EventChannel::<MyEvent>::new();

    ```
  
  - Writing events to the event channel

    - Single

    ```Rust
      extern crate amethyst;
      #[derive(Debug)]
      pub enum MyEvent {
        A,
        B,
      }
      fn main() {
        let mut channel = amethyst::shrev::EventChannel::<MyEvent>::new();
          channel.single_write(MyEvent::A);
      }
    ```

    - Multiple

    ```Rust
      extern crate amethyst;
      #[derive(Debug)]
      pub enum MyEvent {
        A,
        B,
      }
      fn main() {
        let mut channel = amethyst::shrev::EventChannel::<MyEvent>::new();
          channel.iter_write(vec![MyEvent::A, MyEvent::A, MyEvent::B].into_iter());
      }
    ```

- Reading events

  - EventChannels guarantee sending events in order to each reader

  - To subscribe to events, register a reader against the EventChannel to receive a `ReaderId`:

    ```Rust
      extern crate amethyst;
      #[derive(Debug)]
      pub enum MyEvent {
        A,
        B,
      }
      fn main() {
        let mut channel = amethyst::shrev::EventChannel::<MyEvent>::new();
        let mut reader_id = channel.register_reader();
      }
    ```

  - When reading events, pass the `ReaderId` in:

    ```Rust
      extern crate amethyst;
      #[derive(Debug)]
      pub enum MyEvent {
        A,
        B,
      }
      fn main() {
        let mut channel = amethyst::shrev::EventChannel::<MyEvent>::new();
        let mut reader_id = channel.register_reader();
      for event in channel.read(&mut reader_id) {
          // The type of the event is inferred from the generic type
          // we assigned to the `EventChannel<MyEvent>` earlier when creating it.
          println!("Received event value of: {:?}", event);
        } 
      }
    ```
  
  - Note that you only need to have a read access to the channel when reading events. it is the ReaderId that needs to te mutable to keep track your last read was

  > IMPORTANT: The event channel automatically grows as events are added to it and only decreases in size once all readers have read through the older events.
  This mean that if you create a ReaderId but don't read from it on each frame, the event channel will start to consume more and more memory.

- Patterns

  - When using the event channel, we usually re-use the same pattern over and over again to maximize parallelism. it goes as follow.

  - in the producer `System`, get a mutable reference to your resource..

    ```Rust
      extern crate amethyst;
      use amethyst::ecs::Write;
      use amethyst::shrev::EventChannel;
      #[derive(Debug)]
      pub enum MyEvent {
        A,
        B,
      }
      struct MySystem;
      impl<'a> amethyst::ecs::System<'a> for MySystem {
        type SystemData = Write<'a, EventChannel<MyEvent>>;
          fn run(&mut self, _: Self::SystemData) { }
      }
    ```
  
  - in the receiver System you need to store the `ReaderId` somewhere.

    ```Rust
      extern crate amethyst;
      use amethyst::shrev::ReaderId;
      #[derive(Debug)]
      pub enum MyEvent {
        A,
        B,
      }
      struct ReceiverSystem {
          // The type inside of ReaderId should be the type of the event you are using.
          reader: Option<ReaderId<MyEvent>>,
      }
    ```
  
  - And you also need to get read access:

    ```Rust
      extern crate amethyst;
      use amethyst::ecs::Read;
      use amethyst::shrev::EventChannel;
      #[derive(Debug)]
      pub enum MyEvent {
        A,
        B,
      }
      struct MySystem;
      impl<'a> amethyst::ecs::System<'a> for MySystem {
          type SystemData = Read<'a, EventChannel<MyEvent>>;
          fn run(&mut self, _: Self::SystemData) { }
      }
    ```
  
  - Then, in the Systems new method

    ```Rust
      extern crate amethyst;
      use amethyst::shrev::{EventChannel, ReaderId};
      use amethyst::ecs::{System, SystemData, World};
      #[derive(Debug)]
      pub enum MyEvent {
        A,
        B,
      }
      struct MySystem { reader_id: ReaderId<MyEvent>, }

      impl MySystem {
          pub fn new(world: &mut World) -> Self {
              <Self as System<'_>>::SystemData::setup(world);
              let reader_id = world.fetch_mut::<EventChannel<MyEvent>>().register_reader();
              Self { reader_id }
          }
      }

      impl<'a> amethyst::ecs::System<'a> for MySystem {
        type SystemData = ();
        fn run(&mut self, _: Self::SystemData) { }
      }
    ```

  - Finally, you can read events from your `System`

    ```Rust
      extern crate amethyst;
      use amethyst::ecs::Read;
      use amethyst::shrev::EventChannel;
      #[derive(Debug)]
      pub enum MyEvent {
        A,
        B,
      }
      struct MySystem {
        reader_id: amethyst::shrev::ReaderId<MyEvent>,
      }
      impl<'a> amethyst::ecs::System<'a> for MySystem {
          type SystemData = Read<'a, EventChannel<MyEvent>>;
          fn run(&mut self, my_event_channel: Self::SystemData) {
              for event in my_event_channel.read(&mut self.reader_id) {
                  println!("Received an event: {:?}", event);
              }
          }
      }
    ```
