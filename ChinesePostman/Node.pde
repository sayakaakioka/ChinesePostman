import java.util.ArrayDeque;

class Node{
  ArrayDeque<Integer> neighbors = new ArrayDeque<Integer>();
  private String name;
  
  public Node(String name){
    this.name = name;
  }
  
  public String name(){
    return this.name;
  }
  
  public void neighbors(int id){
    this.neighbors.addLast(id);
  }
  
  public int neighbor(){
    int ret;
    try{
      ret = this.neighbors.removeLast();
    } catch(Exception e){
      ret = -1;
    }
    return ret;
  }
  
  public void remove(int id){
    this.neighbors.removeFirstOccurrence(id);
  }
  
}
