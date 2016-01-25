struct Node *makeLeafNode(int val){
  Node *temp;
  temp = (Node*) malloc(sizeof(Node));
  temp -> op = NULL;
  temp -> val = val;
  temp -> left = NULL;
  temp -> right = NULL;
  return temp;
}

Node *makeOperatorNode(char c, Node *l, Node *r){
  Node *temp;
  temp = (Node*) malloc(sizeof(Node));
  temp -> op = malloc(sizeof(char));
  *(temp->op) = c;
  temp -> left = l;
  temp -> right = r;
  return temp;
}

int eval(Node *root){
  if(root->op == NULL){
    return root->val;
  }
  else{
    switch (*(root->op)) {
      case '+':
        return eval(root->left) + eval(root->right);
        break;
      case '/':
        return eval(root->left) / eval(root->right);
        break;
      case '*':
        return eval(root->left) * eval(root->right);
        break;
      case '-':
        return eval(root->left) - eval(root->right);
        break;
      case '<':
        if(eval(root->left) < eval(root->right)) return 1; else return 0;
        break;
      case '>':
        if(eval(root->left) > eval(root->right)) return 1; else return 0;
        break;
    }
  }
}
