typedef struct Node{
  int val;
  char *op;
  struct Node *left;
  struct Node *right;
}Node;

Node* makeLeafNode(int);

Node* makeOperatorNode(char,Node*,Node*);

int eval(Node*);
