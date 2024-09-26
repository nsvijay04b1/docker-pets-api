import express, { Request, Response, Application } from 'express';
import { ParamsDictionary } from 'express-serve-static-core';
import { ParsedQs } from 'qs';
import { v4 as uuidv4 } from 'uuid'; // For generating unique IDs

const app: Application = express();
const port = 3000;

// Middleware to parse JSON request bodies
app.use(express.json());

// In-memory array to store pets
interface Pet {
  id: string;
  name: string;
  age: number;
  type: string;
}

let pets: Pet[] = [
  { id: uuidv4().replace('-','').substring(0,6), name: 'Fluffy', age: 4, type: 'cat' },
  { id: uuidv4().replace('-','').substring(0,6), name: 'Rover', age: 6, type: 'dog' }
];

type ExpressHandler<P = ParamsDictionary, ResBody = any, ReqBody = any, ReqQuery = ParsedQs> = (
  req: Request<P, ResBody, ReqBody, ReqQuery>,
  res: Response<ResBody>
) => void;

// GET /pets - Fetch all pets
app.get('/pets', (req: Request<ParamsDictionary, any, any, ParsedQs>, res: Response) => {
  res.json(pets);
});

// GET /pets/:id - Fetch a single pet by ID
app.get('/pets/:id', (req: Request<{id: string}>, res: Response) => {
  const pet = pets.find(p => p.id === req.params.id);
  if (pet) {
    res.json(pet);
  } else {
    res.status(404).json({ message: 'Pet not found' });
  }
});

app.post('/pets', (req: Request<{}, {}, Omit<Pet, 'id'>>, res: Response) => {
  const { name, age, type } = req.body;
  if (!name || !age || !type) {
    res.status(400).json({ message: 'Invalid input' });
    return;
  }

  const newPet: Pet = {
    id: uuidv4().replace('-','').substring(0,6),
    name,
    age,
    type
  };

  pets.push(newPet);
  res.status(201).json(newPet);
});

app.put('/pets/:id', (req: Request<{id: string}, {}, Omit<Pet, 'id'>>, res: Response) => {
  const petIndex = pets.findIndex(p => p.id === req.params.id);
  if (petIndex === -1) {
    res.status(404).json({ message: 'Pet not found' });
    return;
  }

  const { name, age, type } = req.body;
  if (!name || !age || !type) {
    res.status(400).json({ message: 'Invalid input' });
    return;
  }

  pets[petIndex] = {
    id: pets[petIndex].id,
    name,
    age,
    type
  };

  res.json(pets[petIndex]);
});

app.delete('/pets/:id', (req: Request<{id: string}>, res: Response) => {
  const petIndex = pets.findIndex(p => p.id === req.params.id);
  if (petIndex === -1) {
    res.status(404).json({ message: 'Pet not found' });
    return;
  }

  const [deletedPet] = pets.splice(petIndex, 1);
  res.json(deletedPet);
});


// Start the server
app.listen(port, () => {
  console.log(`Pets API server running at http://localhost:${port}`);
});

